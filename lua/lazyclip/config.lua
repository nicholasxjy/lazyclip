local Config = {
	max_history = 100,
	items_per_page = 9,
	window = {
		relative = "editor",
		width = 70,
		height = 12,
		border = "rounded",
	},
}

function Config.get_window_position()
	return {
		col = math.floor((vim.o.columns - Config.window.width) / 2),
		row = math.floor((vim.o.lines - Config.window.height) / 2),
	}
end

return Config
