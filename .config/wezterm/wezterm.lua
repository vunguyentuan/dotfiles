local wezterm = require("wezterm")
-- local act = wezterm.action

-- Allow working with both the current release and the nightly
local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- config.unix_domains = {
-- 	{
-- 		name = "unix",
-- 	},
-- }

config.ssh_domains = {
	{
		-- This name identifies the domain
		name = "arch",
		-- The hostname or address to connect to. Will be used to match settings
		-- from your ssh config file
		remote_address = "192.168.102.26",
		-- The username to use on the remote host
		username = "vunguyen",
	},
}

-- config.front_end = "WebGpu"
-- config.term = "wezterm"
config.freetype_load_flags = "NO_HINTING"

config.enable_kitty_keyboard = true
config.use_dead_keys = false

config.set_environment_variables = {
  PATH =  wezterm.home_dir.. '/.volta/bin:' .. wezterm.home_dir .. '/.config/scripts:' .. '/opt/homebrew/bin:' .. os.getenv('PATH')
}

require("gui").apply_to_config(config)

local tab_bar = require("tab-bar")

wezterm.on("update-status", tab_bar.on_update_status)

wezterm.on("format-tab-title", tab_bar.on_format_tab_title)

tab_bar.apply_to_config(config)

-- local toggles = require("toggles")

-- wezterm.on("toggle-bg", toggles.on_toggle_bg)

-- wezterm.on("toggle-ligature", toggles.on_toggle_ligature)

local zen_mode = require("zen-mode")

wezterm.on("user-var-changed", zen_mode.on_user_var_change)

require("workspaces").apply_to_config(config)

require("key-bindings").apply_to_config(config)

-- config.debug_key_events = true

return config
