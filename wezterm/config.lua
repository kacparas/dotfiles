local wezterm = require('wezterm')
local config = wezterm.config_builder()

-- PATH
config.set_environment_variables = {
	PATH = '/opt/homebrew/bin:/usr/local/bin:' .. os.getenv('PATH')
}

-- Default shell
config.default_prog = { '/bin/zsh', '-l' }

-- Cursor
config.default_cursor_style = 'BlinkingBar'

-- Tab bar
config.enable_tab_bar = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

-- Behavior
config.automatically_reload_config = true
config.window_close_confirmation = 'NeverPrompt'
config.window_decorations = 'RESIZE'

-- Colors
config.colors = {
    foreground = '#d8dee9',
    background = '#2e3440',
    cursor_bg = '#d8dee9',
    cursor_border = '#d8dee9',
    cursor_fg = '#2e3440',
    selection_bg = '#434c5e',
    selection_fg = '#d8dee9',
    ansi = {
      '#3b4252', '#bf616a', '#a3be8c', '#ebcb8b',
      '#81a1c1', '#b48ead', '#88c0d0', '#e5e9f0',
    },
    brights = {
      '#4c566a', '#bf616a', '#a3be8c', '#ebcb8b',
      '#81a1c1', '#b48ead', '#8fbcbb', '#eceff4',
    },
    tab_bar = {
      background = '#2e3440',
      active_tab = { bg_color = '#4c566a', fg_color = '#eceff4' },
      inactive_tab = { bg_color = '#2e3440', fg_color = '#616e88' },
      inactive_tab_hover = { bg_color = '#3b4252', fg_color = '#d8dee9' },
    },
  }

-- Font
config.font_size = 12.5
config.font = wezterm.font('JetBrainsMono Nerd Font', { weight = 'Bold' })

-- Padding
config.window_padding = { left = 5, right = 0, top = 2, bottom = 0}

-- Transparency
config.background = {
	{ source = { Color = '#2e3440' }, width = '100%', height = '100%', opacity = 0.55 }
}
config.window_background_opacity = 0.85
config.macos_window_background_blur = 10

config.inactive_pane_hsb = {
	saturation = 1.0, 
	brightness = 1.0,
}

-- Keys
config.leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
    { key = 'Enter', mods = 'CTRL', action = wezterm.action({ SendString = '\x1b[13;5u' }) },
    { key = 'Enter', mods = 'SHIFT', action = wezterm.action({ SendString = '\x1b[13;2u' }) },

    -- Tabs
    { key = 'c', mods = 'LEADER', action = wezterm.action.SpawnTab('CurrentPaneDomain') },
    { key = ',', mods = 'LEADER', action = wezterm.action.PromptInputLine({
        description = 'Rename tab',
        action = wezterm.action_callback(function(window, _, line)
          if line then window:active_tab():set_title(line) end
        end),
    }) },
    { key = 'n', mods = 'LEADER', action = wezterm.action.ActivateTabRelative(1) },
    { key = 'p', mods = 'LEADER', action = wezterm.action.ActivateTabRelative(-1) },
    { key = '1', mods = 'LEADER', action = wezterm.action.ActivateTab(0) },
    { key = '2', mods = 'LEADER', action = wezterm.action.ActivateTab(1) },
    { key = '3', mods = 'LEADER', action = wezterm.action.ActivateTab(2) },
    { key = '4', mods = 'LEADER', action = wezterm.action.ActivateTab(3) },
    { key = '5', mods = 'LEADER', action = wezterm.action.ActivateTab(4) },

    -- Panes
    { key = '|', mods = 'LEADER', action = wezterm.action.SplitHorizontal({ domain = 'CurrentPaneDomain' }) },
    { key = '-', mods = 'LEADER', action = wezterm.action.SplitVertical({ domain = 'CurrentPaneDomain' }) },
    { key = 'h', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection('Left') },
    { key = 'j', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection('Down') },
    { key = 'k', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection('Up') },
    { key = 'l', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection('Right') },
    { key = 'x', mods = 'LEADER', action = wezterm.action.CloseCurrentPane({confirm = false}) }
}

return config
