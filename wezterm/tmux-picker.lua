local M = {}

function M.get_default_prog()
    return {
        '/bin/zsh',
        '-l',  -- login shell to load full environment
        '-c',
        '/Users/kasparavicius/.local/bin/tmux-picker'
    }
end

return M
