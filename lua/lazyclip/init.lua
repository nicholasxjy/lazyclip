local Config = require("lazyclip.config")
local M = {}

function M.setup(opts)
	Config = vim.tbl_deep_extend("force", Config, opts or {})
	require("lazyclip.state").init()
end

-- Add the show_clipboard function for backward compatibility
function M.show_clipboard()
	require("lazyclip.ui").open_window()
end

return M
