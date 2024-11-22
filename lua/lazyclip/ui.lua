local M = {}

local state = require("lazyclip.state")

local ITEMS_PER_PAGE = 9
local FLOAT_OPTS = {
	relative = "editor",
	width = 70,
	height = 12,
	col = math.floor((vim.o.columns - 70) / 2),
	row = math.floor((vim.o.lines - 12) / 2),
	border = "rounded",
}

local function sanitize_item(item)
	return item:gsub("\n", " "):sub(1, 30)
end

local function render_content(buffer, start_idx)
	vim.api.nvim_buf_set_lines(buffer, 0, -1, false, {}) -- Clear buffer

	local clipboard = state.get_clipboard()
	for i = 1, ITEMS_PER_PAGE do
		local actual_idx = start_idx + i - 1
		local content = clipboard[actual_idx] and sanitize_item(clipboard[actual_idx]) or ""
		local line = string.format("[%d] - %s", i, content)
		vim.api.nvim_buf_set_lines(buffer, i - 1, i, false, { line })
	end

	local page_info = string.format("Page %d", state.get_current_page())
	vim.api.nvim_buf_set_lines(buffer, ITEMS_PER_PAGE, ITEMS_PER_PAGE + 1, false, { "", page_info })
end

function M.open_clipboard_window()
	local clipboard = state.get_clipboard()
	if #clipboard == 0 then
		print("Clipboard is empty!")
		return
	end

	local buffer = vim.api.nvim_create_buf(false, true)
	local win = vim.api.nvim_open_win(buffer, true, FLOAT_OPTS)

	vim.api.nvim_buf_set_option(buffer, "relativenumber", false)
	vim.api.nvim_buf_set_option(buffer, "number", false)

	render_content(buffer, state.get_start_index())

	vim.api.nvim_buf_set_keymap(
		buffer,
		"n",
		"q",
		":lua vim.api.nvim_win_close(" .. win .. ", true)<CR>",
		{ noremap = true, silent = true }
	)
	vim.api.nvim_buf_set_keymap(
		buffer,
		"n",
		"h",
		":lua require('lazyclip.ui').prev_page(" .. win .. ", " .. buffer .. ")<CR>",
		{ noremap = true, silent = true }
	)
	vim.api.nvim_buf_set_keymap(
		buffer,
		"n",
		"l",
		":lua require('lazyclip.ui').next_page(" .. win .. ", " .. buffer .. ")<CR>",
		{ noremap = true, silent = true }
	)
	vim.api.nvim_buf_set_keymap(
		buffer,
		"n",
		"<CR>",
		":lua require('lazyclip.ui').paste_selected(" .. win .. ")<CR>",
		{ noremap = true, silent = true }
	)

	for i = 1, ITEMS_PER_PAGE do
		local key = tostring(i)
		vim.api.nvim_buf_set_keymap(
			buffer,
			"n",
			key,
			string.format(":lua require('lazyclip.ui').paste_and_close(%d, %d)<CR>", win, i),
			{ noremap = true, silent = true }
		)
	end
end

function M.paste_and_close(win, index)
	local clipboard = state.get_clipboard()
	local start_idx = state.get_start_index()
	local actual_idx = start_idx + index - 1

	if clipboard[actual_idx] then
		vim.api.nvim_win_close(win, true)
		vim.api.nvim_paste(clipboard[actual_idx], false, -1)
	else
		print("Invalid index!")
	end
end

function M.prev_page(win, buffer)
	if state.prev_page() then
		render_content(buffer, state.get_start_index())
	end
end

function M.next_page(win, buffer)
	if state.next_page() then
		render_content(buffer, state.get_start_index())
	end
end

function M.paste_selected(win)
	local cursor = vim.api.nvim_win_get_cursor(win)
	local line = cursor[1]

	local start_idx = state.get_start_index()
	local actual_idx = start_idx + line - 1

	local clipboard = state.get_clipboard()
	if clipboard[actual_idx] then
		vim.api.nvim_win_close(win, true)
		vim.api.nvim_paste(clipboard[actual_idx], false, -1)
	else
		print("Invalid selection!")
	end
end

return M
