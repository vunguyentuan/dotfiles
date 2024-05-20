-- Load the hotkey module
local hotkey = require("hs.hotkey")

-- Bind shortcuts to applications
hotkey.bind({"shift", "alt", "ctrl"}, "f", function() hs.application.launchOrFocus("Alacritty") end)
hotkey.bind({"shift", "alt", "ctrl"}, "d", function() hs.application.launchOrFocus("Google Chrome") end)
hotkey.bind({"shift", "alt", "ctrl"}, "s", function() hs.application.launchOrFocus("Figma") end)
hotkey.bind({"shift", "alt", "ctrl"}, "a", function() hs.application.launchOrFocus("Slack") end)

