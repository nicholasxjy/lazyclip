local M = {}

function M.setup(opts)
	if opts then
		local config = require("lazyclip.config")
		config = vim.tbl_deep_extend("force", config, opts)
	end

	require("lazyclip.state").init()

	if opts then
		-- Deep merge the entire configuration
		config = vim.tbl_deep_extend("force", config, opts)

		-- Special handling for keymaps to allow partial override
		if opts.keymaps then
			config.keymaps = vim.tbl_deep_extend("force", config.keymaps, opts.keymaps)
		end
	end

	-- Set default keybinding
	vim.keymap.set(
		"n",
		"<leader>Cw",
		":lua require('lazyclip.ui').open_window()<CR>",
		{ noremap = true, silent = true, desc = "Open Clipboard Manager" }
	)
end

-- Add the show_clipboard function for backward compatibility
function M.show_clipboard()
	require("lazyclip.ui").open_window()
end

return M
