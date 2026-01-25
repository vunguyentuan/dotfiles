local wezterm = require("wezterm")

local gui = {}

function gui.apply_to_config(config)
	config.max_fps = 120
	-- config.animation_fps = 60

	config.color_scheme = "Catppuccin Mocha"
	-- config.color_scheme = "carbonfox"

	config.window_decorations = "RESIZE"

	config.font = wezterm.font({
		family = "JetBrains Mono",
		weight = "Medium",
		harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
	})

	-- example arrows: -> => ==> <-> and inequalities: <= >=
	config.adjust_window_size_when_changing_font_size = false
	config.font_size = 16.0
	config.line_height = 1.2

	config.inactive_pane_hsb = {
		brightness = 0.5,
	}

	config.macos_window_background_blur = 10

	-- background of special text (e.g. which-key in nvim)
	config.text_background_opacity = 0.4
end

return gui
