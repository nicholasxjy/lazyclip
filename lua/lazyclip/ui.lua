local State = require("lazyclip.state")
local Config = require("lazyclip.config")
local api = vim.api
local notify = vim.notify
local keymap = vim.keymap
local log_levels = vim.log.levels

local UI = {}

local function create_window_options()
	local pos = Config.get_window_position()
	return vim.tbl_extend("force", Config.window, pos)
end

local function sanitize_display_text(text)
	return text:gsub("\n", " "):sub(1, 30)
end

local function create_display_line(index, content)
	return string.format("[%d] - %s", index, sanitize_display_text(content))
end

local function render_content(bufnr)
	local lines = {}

	for i = 1, Config.items_per_page do
		local item = State.get_item_at_index(i)
		lines[i] = create_display_line(i, item or "")
	end

	-- Add page info with total pages
	lines[#lines + 1] = ""
	lines[#lines + 1] = string.format("Page %d/%d", State.current_page, State.get_total_pages())

	api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
end

local function setup_buffer_keymaps(bufnr, winnr)
	local keymaps = {
		{
			"n",
			"q",
			function()
				api.nvim_win_close(winnr, true)
			end,
		},
		{
			"n",
			"h",
			function()
				UI.navigate_page(winnr, bufnr, -1)
			end,
		},
		{
			"n",
			"l",
			function()
				UI.navigate_page(winnr, bufnr, 1)
			end,
		},
		{
			"n",
			"<CR>",
			function()
				UI.paste_selected(winnr)
			end,
		},
	}

	-- Add number keymaps
	for i = 1, Config.items_per_page do
		table.insert(keymaps, {
			"n",
			tostring(i),
			function()
				UI.paste_and_close(winnr, i)
			end,
		})
	end

	-- Apply keymaps
	for _, map in ipairs(keymaps) do
		keymap.set(map[1], map[2], map[3], {
			buffer = bufnr,
			noremap = true,
			silent = true,
		})
	end
end

function UI.open_window()
	if #State.clipboard == 0 then
		notify("Clipboard is empty!", log_levels.INFO)
		return
	end

	local bufnr = api.nvim_create_buf(false, true)
	local winnr = api.nvim_open_win(bufnr, true, create_window_options())

	-- Configure buffer
	api.nvim_buf_set_option(bufnr, "relativenumber", false)
	api.nvim_buf_set_option(bufnr, "number", false)

	render_content(bufnr)
	setup_buffer_keymaps(bufnr, winnr)
end

function UI.navigate_page(_, bufnr, direction)
	if State.navigate_page(direction) then
		render_content(bufnr)
	end
end

function UI.paste_and_close(winnr, index)
	local item = State.get_item_at_index(index)
	if item then
		api.nvim_win_close(winnr, true)
		api.nvim_paste(item, false, -1)
	else
		notify("Invalid index!", log_levels.WARN)
	end
end

function UI.paste_selected(winnr)
	local cursor = api.nvim_win_get_cursor(winnr)
	local line = cursor[1]
	local item = State.get_item_at_index(line)

	if item then
		api.nvim_win_close(winnr, true)
		api.nvim_paste(item, false, -1)
	else
		notify("Invalid selection!", log_levels.WARN)
	end
end

return UI
