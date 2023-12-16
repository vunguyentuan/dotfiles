local wezterm = require('wezterm')
local my_tab_bar = require('tab-bar')

local toggles = {}

function toggles.on_toggle_bg(window, _)
    local overrides = window:get_config_overrides() or {}
    if not overrides.background then
        overrides.background = {}
        overrides.colors = {
            background = '#1a212e',
            tab_bar = {
                background = '#1a212e',
                active_tab = {
                    bg_color = '#1a212e',
                    fg_color = 'rgb(75,185,55)',
                    -- intensity = 'Bold'
                },
                inactive_tab = {
                    bg_color = '#1a212e',
                    fg_color = 'rgb(94,172,211)' -- = '#5eacd3'
                },
                new_tab = {
                    bg_color = '#1a212e',
                    fg_color = 'rgb(210,55,100)'
                },
            },
        }
        overrides.text_background_opacity = 1.0
        my_tab_bar.bg_color = '#1a212e'
    else
        overrides.background = nil
        overrides.colors = nil
        overrides.text_background_opacity = nil
        my_tab_bar.bg_color = 'none'
    end
    window:set_config_overrides(overrides)
end

-- --> -> ==> => ==<
function toggles.on_toggle_ligature(window, _)
    local overrides = window:get_config_overrides() or {}
    if not overrides.font then
        -- If we haven't overridden it yet, then override with ligatures enabled
        overrides.font = wezterm.font({
            family = 'JetBrains Mono',
            weight = 'Medium',
            harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' },
        })
    else
        -- else we did already, and we should disable out override now
        overrides.font = nil
    end
    window:set_config_overrides(overrides)
end

return toggles
