local M = {}

function M.setup(opts)
	local config = require("lazyclip.config")
	config = vim.tbl_deep_extend("force", config, opts or {})

	require("lazyclip.state").init()

	-- Set default keybinding
	-- vim.keymap.set(
	-- 	"n",
	-- 	"<leader>Cw",
	-- 	":lua require('lazyclip.ui').open_window()<CR>",
	-- 	{ noremap = true, silent = true, desc = "Open Clipboard Manager" }
	-- )
end

-- Add the show_clipboard function for backward compatibility
function M.show_clipboard()
	require("lazyclip.ui").open_window()
end

return M
