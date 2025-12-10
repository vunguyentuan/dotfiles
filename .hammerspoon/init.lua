-- Load the hotkey module
local hotkey = require("hs.hotkey")

-- Bind shortcuts to applications
hotkey.bind({"shift", "alt", "ctrl", "cmd"}, "g", function() hs.application.launchOrFocus("Figma") end)
hotkey.bind({"shift", "alt", "ctrl", "cmd"}, "f", function() hs.application.launchOrFocus("Wezterm") end)
-- hotkey.bind({"shift", "alt", "ctrl", "cmd"}, "f", function() hs.application.launchOrFocus("Ghostty") end)
-- hotkey.bind({"shift", "alt", "ctrl", "cmd"}, "f", function() hs.application.launchOrFocus("Kitty") end)
hotkey.bind({"shift", "alt", "ctrl", "cmd"}, "d", function() hs.application.launchOrFocus("Google Chrome") end)
hotkey.bind({"shift", "alt", "ctrl", "cmd"}, "s", function() hs.application.launchOrFocus("Notes") end)
hotkey.bind({"shift", "alt", "ctrl", "cmd"}, "a", function() hs.application.launchOrFocus("Slack") end)
hotkey.bind({"shift", "alt", "ctrl", "cmd"}, "c", function() hs.application.launchOrFocus("Visual Studio Code") end)
hotkey.bind({"shift", "alt", "ctrl", "cmd"}, "x", function() hs.application.launchOrFocus("Xcode") end)

