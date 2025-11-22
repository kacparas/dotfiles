local wezterm = require('wezterm')
local config = wezterm.config_builder()

-- PATH configuration
config.set_environment_variables = {
	PATH = '/opt/homebrew/bin:/usr/local/bin:' .. os.getenv('PATH')
}

-- Launch tmux session picker using the module
local tmux_picker = require('tmux-picker')
config.default_prog = tmux_picker.get_default_prog()

config.default_cursor_style = 'BlinkingBar'
config.automatically_reload_config = true
config.window_close_confirmation = 'NeverPrompt'
config.window_decorations = 'RESIZE'

-- disables wezterm tabs
config.enable_tab_bar = false

-- font
config.font_size = 12.5
config.font = wezterm.font('JetBrainsMono Nerd Font', { weight = 'Bold'})

-- Nord colors
config.colors = {
	-- Base colors
	foreground = '#d8dee9',  -- nord4
	background = '#2e3440',  -- nord0
	cursor_bg = '#d8dee9',   -- nord4
	cursor_border = '#d8dee9',
	cursor_fg = '#2e3440',   -- nord0
	selection_bg = '#434c5e', -- nord2
	selection_fg = '#d8dee9',

	-- ANSI colors
	ansi = {
		'#3b4252', -- black (nord1)
		'#bf616a', -- red (nord11)
		'#a3be8c', -- green (nord14)
		'#ebcb8b', -- yellow (nord13)
		'#81a1c1', -- blue (nord9)
		'#b48ead', -- magenta (nord15)
		'#88c0d0', -- cyan (nord8)
		'#e5e9f0', -- white (nord5)
	},

	-- Bright colors
	brights = {
		'#4c566a', -- bright black (nord3)
		'#bf616a', -- bright red (nord11)
		'#a3be8c', -- bright green (nord14)
		'#ebcb8b', -- bright yellow (nord13)
		'#81a1c1', -- bright blue (nord9)
		'#b48ead', -- bright magenta (nord15)
		'#8fbcbb', -- bright cyan (nord7)
		'#eceff4', -- bright white (nord6)
	},
}

-- padding
config.window_padding = {
	left = 5,
	right = 0,
	top = 2,
	bottom = 0,
}

-- background with transparency
config.background = {
	{
		source = {
			Color = '#2e3440', -- Changed to nord0 instead of nord4
		},
		width = '100%',
		height = '100%',
		opacity = 0.55, 
	}
}
config.window_background_opacity = 0.85
config.macos_window_background_blur = 10

-- keybindings
config.keys = {
	{ key = 'Enter', mods = 'CTRL', action = wezterm.action({ SendString = '\x1b[13;5u' }) },
	{ key = 'Enter', mods = 'SHIFT', action = wezterm.action({ SendString = '\x1b[13;2u' }) },
}

return config
