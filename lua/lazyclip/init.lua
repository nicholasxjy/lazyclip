local M = {}

local ui = require("lazyclip.ui")
local state = require("lazyclip.state")

function M.setup()
	-- Default keybindings
	vim.api.nvim_set_keymap(
		"n",
		"<leader>Cw",
		":lua require('lazyclip').show_clipboard()<CR>",
		{ noremap = true, silent = true }
	)
end

function M.show_clipboard()
	ui.open_clipboard_window()
end

return M
