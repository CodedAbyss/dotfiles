local wezterm = require('wezterm')

local config = wezterm.config_builder()

config.color_scheme = 'rose-pine'
config.enable_tab_bar = false
config.window_decorations = 'RESIZE'

config.window_background_opacity = 0.9
config.macos_window_background_blur = 10
local act = wezterm.action

local SHIFT_CMD = 'SHIFT|CMD'
local CMD = 'CMD'

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
	SHIFT_CMD = 'SHIFT|CTRL'
	CMD = 'ALT'
	config.window_decorations = 'RESIZE|TITLE'
end

config.keys = {
	{ key = '|', mods = SHIFT_CMD, action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
	{ key = '-', mods = CMD, action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
	{ key = 'h', mods = CMD, action = act.ActivatePaneDirection('Left') },
	{ key = 'j', mods = CMD, action = act.ActivatePaneDirection('Down') },
	{ key = 'k', mods = CMD, action = act.ActivatePaneDirection('Up') },
	{ key = 'l', mods = CMD, action = act.ActivatePaneDirection('Right') },
	
	{ key = 'h', mods = SHIFT_CMD, action = act.AdjustPaneSize { 'Left', 1 } },
	{ key = 'j', mods = SHIFT_CMD, action = act.AdjustPaneSize { 'Down', 1 } },
	{ key = 'k', mods = SHIFT_CMD, action = act.AdjustPaneSize { 'Up', 1 } },
	{ key = 'l', mods = SHIFT_CMD, action = act.AdjustPaneSize { 'Right', 1 } },
	
	{ key = 'm', mods = CMD, action = act.DisableDefaultAssignment },
	{ key = 'm', mods = CMD, action = act.ToggleFullScreen },
}

return config