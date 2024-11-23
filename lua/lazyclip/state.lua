local Config = require("lazyclip.config")

local State = {
	clipboard = {},
	current_page = 1,
}

function State.add_item(item)
	if not item or item == "" then
		return
	end
	table.insert(State.clipboard, 1, item)
	if #State.clipboard > Config.max_history then
		table.remove(State.clipboard)
	end
end

function State.get_page_bounds()
	local start_index = (State.current_page - 1) * Config.items_per_page + 1
	local end_index = math.min(start_index + Config.items_per_page - 1, #State.clipboard)
	return start_index, end_index
end

function State.get_total_pages()
	return math.ceil(#State.clipboard / Config.items_per_page)
end

function State.navigate_page(direction)
	local new_page = State.current_page + direction
	if new_page >= 1 and new_page <= State.get_total_pages() then
		State.current_page = new_page
		return true
	end
	return false
end

function State.get_item_at_index(index)
	local start_idx = (State.current_page - 1) * Config.items_per_page + 1
	return State.clipboard[start_idx + index - 1]
end

-- Setup TextYankPost autocmd
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		State.add_item(vim.fn.getreg('"'))
	end,
})

return State
