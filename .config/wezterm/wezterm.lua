local wezterm = require("wezterm")

-- Allow working with both the current release and the nightly
local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end


config.use_ime = false
config.freetype_load_flags = "NO_HINTING"
config.enable_kitty_keyboard = true
config.use_dead_keys = false

config.set_environment_variables = {
  PATH =  wezterm.home_dir.. '/.volta/bin:' .. wezterm.home_dir .. '/.config/scripts:' .. '/opt/homebrew/bin:' .. os.getenv('PATH')
}

require("gui").apply_to_config(config)

local tab_bar = require("tab-bar")

wezterm.on("format-tab-title", tab_bar.on_format_tab_title)

wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
  local zoomed = ""
  if tab.active_pane.is_zoomed then
    zoomed = "[Z] "
  end

  local index = ""
  if #tabs > 1 then
    index = string.format("[%d/%d] ", tab.tab_index + 1, #tabs)
  end

  local cwd = ""
  if pane.current_working_dir then
    local uri = tostring(pane.current_working_dir)
    if string.find(uri, "file://") then
      cwd = string.gsub(uri, "file://[^/]*", "")
    end
    if cwd ~= "" then
      cwd = " - " .. cwd
    end
  end

  return zoomed .. index .. tab.active_pane.title .. cwd
end)

tab_bar.apply_to_config(config)

require("workspaces").apply_to_config(config)

require("key-bindings").apply_to_config(config)

return config
