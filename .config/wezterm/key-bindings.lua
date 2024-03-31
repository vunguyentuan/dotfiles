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

local function getRaltiveDir(pane)
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
		-- Turn off the default CTRL-SHIFT-Space action (so it can potentially be used in tmux)
		-- {
		--     key = 'Space',
		--     mods = 'CTRL|SHIFT',
		--     action = act.DisableDefaultAssignment,
		-- },
		{
			key = "f",
			mods = "CTRL",
			action = wezterm.action_callback(function(win, pane)
				local relativeDir = getRaltiveDir(pane)

				if relativeDir == nil then
					win:perform_action(
						act.SpawnCommandInNewTab({
							args = {
								"yazi",
							},
						}),
						pane
					)
					return
				end

				win:perform_action(
					act.SpawnCommandInNewTab({
						args = {
							"yazi",
							relativeDir,
						},
					}),
					pane
				)
			end),
		},
		{
			key = "g",
			mods = "CMD",

			action = wezterm.action_callback(function(win, pane)
				local relativeDir = getRaltiveDir(pane)

				if relativeDir == nil then
					win:perform_action(
						act.SpawnCommandInNewTab({
							args = {
								"/opt/homebrew/bin/lazygit",
							},
							position = {
								x = 0,
								y = 0,
							},
						}),
						pane
					)

					return
				end

				win:perform_action(
					act.SpawnCommandInNewTab({
						args = {
							"/opt/homebrew/bin/lazygit",
							relativeDir,
						},
						position = {
							x = 0,
							y = 0,
						},
					}),
					pane
				)
			end),
		},
		{
			key = "s",
			mods = "CMD",
			action = wezterm.action.SendString("\x1b:w\r\n"),
			-- https://wezfurlong.org/wezterm/config/lua/keyassignment/SendString.html
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
			key = "Tab",
			mods = "ALT|SHIFT",
			action = act.ActivatePaneDirection("Prev"),
		},
		{
			key = "w",
			mods = "ALT",
			action = act.CloseCurrentPane({ confirm = true }),
		},
		{
			key = "s",
			mods = "LEADER",
			action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "v",
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
			key = "z",
			mods = "LEADER",
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
			key = ",",
			mods = "LEADER",
			action = act.PaneSelect({
				alphabet = "1234567890",
				mode = "SwapWithActive",
			}),
		},
		{
			key = "r",
			mods = "LEADER",
			action = act.RotatePanes("CounterClockwise"),
		},
		{
			key = "h",
			mods = "ALT",
			action = act.ActivatePaneDirection("Left"),
		},
		{
			key = "l",
			mods = "ALT",
			action = act.ActivatePaneDirection("Right"),
		},
		{
			key = "k",
			mods = "ALT",
			action = act.ActivatePaneDirection("Up"),
		},
		{
			key = "j",
			mods = "ALT",
			action = act.ActivatePaneDirection("Down"),
		},
		{
			key = "LeftArrow",
			mods = "ALT",
			action = act.AdjustPaneSize({ "Left", 1 }),
		},
		{
			key = "RightArrow",
			mods = "ALT",
			action = act.AdjustPaneSize({ "Right", 1 }),
		},
		{
			key = "UpArrow",
			mods = "ALT",
			action = act.AdjustPaneSize({ "Up", 1 }),
		},
		{
			key = "DownArrow",
			mods = "ALT",
			action = act.AdjustPaneSize({ "Down", 1 }),
		},
		{
			key = "UpArrow",
			mods = "ALT|CMD",
			action = act.SwitchWorkspaceRelative(1),
		},
		{
			key = "DownArrow",
			mods = "ALT|CMD",
			action = act.SwitchWorkspaceRelative(-1),
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

	for i = 1, 9 do
		table.insert(config.keys, {
			key = tostring(i),
			mods = "LEADER",
			action = act.ActivateTab(i - 1),
		})
	end

	config.mouse_bindings = {
		{
			event = { Down = { streak = 2, button = "Left" } },
			action = act.SelectTextAtMouseCursor("SemanticZone"),
			mods = "SHIFT",
		},
	}
end

return keys
