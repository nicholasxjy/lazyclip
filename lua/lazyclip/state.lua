local M = {}

local clipboard = {}
local current_page = 1

function M.get_clipboard()
	return clipboard
end

function M.add_to_clipboard(item)
	table.insert(clipboard, 1, item)
	if #clipboard > 100 then
		table.remove(clipboard)
	end
end

function M.get_start_index()
	return (current_page - 1) * 9 + 1
end

function M.get_current_page()
	return current_page
end

function M.get_total_pages()
	return math.ceil(#clipboard / 9)
end

function M.prev_page()
	if current_page > 1 then
		current_page = current_page - 1
		return true
	end
	return false
end

function M.next_page()
	if current_page < M.get_total_pages() then
		current_page = current_page + 1
		return true
	end
	return false
end

function M.paste_clipboard(index)
	local start_idx = M.get_start_index()
	local actual_idx = start_idx + index - 1
	if clipboard[actual_idx] then
		vim.api.nvim_paste(clipboard[actual_idx], false, -1)
	else
		print("Invalid index!")
	end
end

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		local yanked_text = vim.fn.getreg('"')
		if yanked_text and yanked_text ~= "" then
			M.add_to_clipboard(yanked_text)
		end
	end,
})

return M
