local wezterm = require("wezterm")
-- local act = wezterm.action

-- Allow working with both the current release and the nightly
local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- config.front_end = "WebGpu"
-- config.term = "wezterm"
config.freetype_load_flags = "NO_HINTING"

config.enable_kitty_keyboard = true
config.use_dead_keys = false

-- This doens't seem to work? If it is fixed, it would be good to include
-- Currently: PATH = /usr/bin:/bin:/usr/sbin:/sbin when running from wezterm
-- config.set_environment_variables = {
--   PATH = '/Users/daniel/.config/scripts:' .. '/opt/homebrew/bin:' .. os.getenv('PATH')
-- }

-- This might not be a good idea?
-- config.default_prog = { '/opt/homebrew/bin/zsh', '-l' }

require("gui").apply_to_config(config)

local tab_bar = require("tab-bar")

wezterm.on("update-status", tab_bar.on_update_status)

wezterm.on("format-tab-title", tab_bar.on_format_tab_title)

tab_bar.apply_to_config(config)

local toggles = require("toggles")

wezterm.on("toggle-bg", toggles.on_toggle_bg)

wezterm.on("toggle-ligature", toggles.on_toggle_ligature)

local zen_mode = require("zen-mode")

wezterm.on("user-var-changed", zen_mode.on_user_var_change)

require("workspaces").apply_to_config(config)

require("key-bindings").apply_to_config(config)

-- config.debug_key_events = true

return config
