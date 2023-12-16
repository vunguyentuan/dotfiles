local wezterm = require("wezterm")

local tab_bar = {}

function tab_bar.apply_to_config(config)
	config.hide_tab_bar_if_only_one_tab = false
	config.tab_bar_at_bottom = false

	config.use_fancy_tab_bar = false
	config.show_tabs_in_tab_bar = true
	config.show_new_tab_button_in_tab_bar = true

	-- retro tab bar
	config.tab_max_width = 32
	config.colors = {
		-- selection_fg = 'white',
		-- selection_bg = 'white',
		tab_bar = {
			background = "none", -- 'rgba(0,0,0,0)',
			active_tab = {
				bg_color = "none", -- 'rgba(0,0,0,0)',
				fg_color = "rgb(75,185,55)",
				-- intensity = 'Bold',
			},
			inactive_tab = {
				bg_color = "none", -- 'rgba(0,0,0,0)',
				fg_color = "rgb(94,172,211)", -- = '#5eacd3'
			},
			new_tab = {
				bg_color = "none",
				fg_color = "rgb(210,55,100)",
			},
		},
	}
end

tab_bar.bg_color = "none"

function tab_bar.on_update_status(window, pane)
	-- Figure out the cwd and host of the current pane.
	-- This will pick up the hostname for the remote host if your
	-- shell is using OSC 7 on the remote host.
	local cwd_uri = pane:get_current_working_dir()
	local right_status = {}
	local left_status = {}
	if cwd_uri then
		local cwd = ""
		local hostname = ""
		if type(cwd_uri) == "userdata" then
			-- Running on a newer version of wezterm and we have
			-- a URL object here, making this simple!
			cwd = cwd_uri.file_path
			hostname = cwd_uri.host or wezterm.hostname()
		else
			-- an older version of wezterm, 20230712-072601-f4abf8fd or earlier,
			-- which doesn't have the Url object
			cwd_uri = cwd_uri:sub(8)
			local slash = cwd_uri:find("/")
			if slash then
				hostname = cwd_uri:sub(1, slash - 1)
				-- and extract the cwd from the uri, decoding %-encoding
				cwd = cwd_uri:sub(slash):gsub("%%(%x%x)", function(hex)
					return string.char(tonumber(hex, 16))
				end)
			end
		end

		-- Remove the domain name portion of the hostname
		local dot = hostname:find("[.]")
		if dot then
			hostname = hostname:sub(1, dot - 1)
		end
		if hostname == "" then
			hostname = wezterm.hostname()
		end

		-- Format cwd nicely
		-- if hostname == 'daniels-mbp' then
		--     -- wezterm.home_dir = '/Users/daniel'
		--     cwd = cwd:gsub(wezterm.home_dir, '~')
		-- end
		cwd = cwd:gsub(wezterm.home_dir, "~")

		left_status = {
			{ Foreground = { Color = "rgb(210,55,100)" } },
			{ Background = { Color = tab_bar.bg_color } },
			-- { Attribute = { Italic = true } },
			-- { Text = "  Workspace:  " },

			{ Attribute = { Italic = false } },
			{ Text = "  " .. window:active_workspace() .. "     " },
		}

		-- right_status = {
		--     { Background = { Color = tab_bar.bg_color } },

		--     { Foreground = { Color = 'rgb(94,172,211)' } },
		--     { Attribute = { Italic = true } },
		--     { Text = 'in  ' },

		--     { Foreground = { Color = 'rgb(210,55,100)' } },
		--     { Attribute = { Italic = false } },
		--     { Text = cwd },

		--     { Foreground = { Color = 'rgb(94,172,211)' } },
		--     { Attribute = { Italic = true } },
		--     { Text = '  @  ' },

		--     { Foreground = { Color = 'rgb(210,55,100)' } },
		--     { Attribute = { Italic = false } },
		--     { Text = hostname .. '  ' },
		-- }
	end
	--
	window:set_left_status(wezterm.format(left_status))
	window:set_right_status(wezterm.format(right_status))
end

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
local function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return tab_info.active_pane.title
end

function tab_bar.on_format_tab_title(tab, _tabs, _panes, _config, _hover, _max_width)
	local zoomed = ""
	local index = tab.tab_index + 1
	local title = tab_title(tab)
	if tab.active_pane.is_zoomed then
		zoomed = "+"
	end
	return {
		{ Text = " " .. index .. " " .. title .. zoomed .. " " },
	}
end

return tab_bar
