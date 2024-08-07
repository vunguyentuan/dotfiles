local wezterm = require("wezterm")
local act = wezterm.action

local workspaces = require("workspaces")

WORKSPACES_HISTORY = {}

wezterm.on("update-right-status", function(window)
  local current_workspace = window:active_workspace()
  local temp = WORKSPACES_HISTORY

  local last_workspace = temp[#temp]

  if last_workspace ~= current_workspace then
    table.insert(temp, current_workspace)
    WORKSPACES_HISTORY = temp
  end

  window:set_right_status(window:active_workspace())
end)

local keys = {}

local function getRelativeDir(pane)
  local current_pane = wezterm.mux.get_pane(pane:pane_id())
  local input = current_pane:get_lines_as_text()

  -- Split the input by newline characters
  local lines = {}
  for line in input:gmatch("[^\r\n]+") do
    table.insert(lines, line)
  end

  -- Get the last line (assuming it's the NOR line)
  local lastLine = lines[#lines]

  -- Extract the directory from the last line
  local relativeDir = lastLine:match("%s*%S+%s+(.-)%s*%d+%s+sel%s+%d+:%d+")

  return relativeDir
end

function keys.apply_to_config(config)
  config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 3000 }

  config.keys = {
    {
      key = "f",
      mods = "CMD|CTRL",
      action = wezterm.action_callback(function(win, pane)
        local relativeDir = getRelativeDir(pane)
        local new_pane = pane:split({
          args = {
            "yazi",
            relativeDir,
          },
        })

        win:perform_action(act.TogglePaneZoomState, new_pane)
      end),
    },
    {
      key = "g",
      mods = "CMD",

      action = wezterm.action_callback(function(win, pane)
        local new_pane = pane:split({
          args = {
            "lazygit",
          },
        })

        win:perform_action(act.TogglePaneZoomState, new_pane)
      end),
    },
    {
      key = "l",
      mods = "CMD",
      action = wezterm.action_callback(function(win, pane)
        local current_workspace = win:active_workspace()
        local temp = WORKSPACES_HISTORY
        local last_workspace = temp[#temp - 1]

        if last_workspace ~= nil and current_workspace ~= last_workspace then
          win:perform_action(
            act.SwitchToWorkspace({
              name = last_workspace,
            }),
            pane
          )
        end
      end),
    },
    {
      key = "Tab",
      mods = "ALT",
      action = act.ActivatePaneDirection("Next"),
    },
    {
      key = "w",
      mods = "ALT",
      action = act.CloseCurrentPane({ confirm = true }),
    },
    {
      key = "v",
      mods = "LEADER",
      action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    {
      key = "s",
      mods = "LEADER",
      action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    {
      key = "b",
      mods = "LEADER",
      action = act.EmitEvent("toggle-bg"),
    },
    {
      key = "l",
      mods = "LEADER",
      action = act.EmitEvent("toggle-ligature"),
    },
    {
      key = "+",
      mods = "CMD",
      action = act.IncreaseFontSize,
    },
    {
      key = "c",
      mods = "LEADER",
      action = act.ActivateCopyMode,
    },
    {
      key = "p",
      mods = "CMD",
      action = act.ActivateCommandPalette,
    },
    {
      key = "w",
      mods = "CMD",
      action = act.CloseCurrentPane({ confirm = false }),
    },
    {
      key = "f",
      mods = "CMD",
      action = act.TogglePaneZoomState,
    },
    {
      key = "?",
      mods = "LEADER",
      action = act.ShowLauncherArgs({ title = "Choose Command", flags = "FUZZY|COMMANDS" }),
      -- seems to be the same as below
      -- action = act.ShowLauncherArgs { title = 'Keys', flags = 'FUZZY|KEY_ASSIGNMENTS|COMMANDS' }
    },
    {
      key = "t",
      mods = "LEADER",
      action = act.ShowLauncherArgs({ title = "Switch Tab", flags = "FUZZY|TABS" }),
    },
    {
      key = "k",
      mods = "CMD",
      action = act.ShowLauncherArgs({ title = "Switch Workspace", flags = "FUZZY|WORKSPACES" }),
    },
    {
      key = ".",
      mods = "LEADER",
      action = act.PaneSelect({
        alphabet = "1234567890",
      }),
    },
    {
      key = "o",
      mods = "CMD|CTRL",
      action = act.RotatePanes("CounterClockwise"),
    },
    {
      key = "j",
      mods = "CMD",
      action = wezterm.action_callback(workspaces.fuzzy_picker),
    },
    {
      key = "d",
      mods = "LEADER",
      action = act.ShowDebugOverlay,
    },
    -- Shell Integration commands:
    {
      key = "UpArrow",
      mods = "SHIFT",
      action = act.ScrollToPrompt(-1),
    },
    {
      key = "DownArrow",
      mods = "SHIFT",
      action = act.ScrollToPrompt(1),
    },
  }

  local function createKeyBinding(key, cwd)
    local workspaceName = "Govtech 󰳠  " .. cwd:match(".*/(.*)")
    local absolutePath = wezterm.home_dir .. "/" .. cwd
    return {
      key = key,
      mods = "ALT|SHIFT|CTRL",
      action = act.SwitchToWorkspace({
        name = workspaceName,
        spawn = {
          cwd = absolutePath,
        },
      }),
    }
  end

  local keyPathPairs = {
    r = "Projects/Govtech/pulsebackend",
    e = "Projects/Govtech/pulseagencyportal",
    w = "Projects/Govtech/pulseportal",
    q = "Projects/Govtech/crowdtasksgbackend",
    t = "Projects/Govtech/crowdtaskcitizenportal",
  }

  for key, path in pairs(keyPathPairs) do
    table.insert(config.keys, createKeyBinding(key, path))
  end

  local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")

  -- you can put the rest of your Wezterm config here
  smart_splits.apply_to_config(config, {
    -- the default config is here, if you'd like to use the default keys,
    -- you can omit this configuration table parameter and just use
    -- smart_splits.apply_to_config(config)

    -- directional keys to use in order of: left, down, up, right
    direction_keys = { "h", "j", "k", "l" },

    -- modifier keys to combine with direction_keys
    modifiers = {
      move = "CTRL",    -- modifier to use for pane movement, e.g. CTRL+h to move left
      resize = "CMD|CTRL", -- modifier to use for pane resize, e.g. META+h to resize to the left
    },
  })

  config.mouse_bindings = {
    {
      event = { Down = { streak = 2, button = "Left" } },
      action = act.SelectTextAtMouseCursor("SemanticZone"),
      mods = "SHIFT",
    },
  }
end

return keys
