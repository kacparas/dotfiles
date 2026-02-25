# Dotfiles

Personal configuration files for macOS development environment.

## Contents

- **nvim** - Neovim configuration (lazy.nvim, Telescope, Neo-tree, Iron.nvim)
- **tmux** - Tmux with Nord theme and TPM plugins
- **aerospace** - Tiling window manager
- **wezterm** - Terminal emulator
- **yatoro** - Apple Music TUI
- **zsh** - Shell configuration with Powerlevel10k

## Installation

### Prerequisites

Install Homebrew, then run:

```bash
git clone https://github.com/kacparas/dotfiles.git ~/repos/dotfiles
cd ~/repos/dotfiles
./install.sh
```

`install.sh` will run `brew bundle` to install all packages from the Brewfile, then create symlinks for all configs.

### Post-install

1. Install tmux plugins:
```bash
# Start tmux and press prefix + I (Ctrl-b I)
```

2. Install Neovim plugins:
```bash
nvim  # Lazy.nvim will auto-install plugins on first launch
```

## Key Bindings

### Neovim

- Leader: `Space`
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>e` - Toggle file explorer
- `<leader>rf` - Start Python REPL
- `<leader>sl` - Send line to REPL
- `<leader>vs` - Select Python venv

### Tmux

- Prefix: `Ctrl-b`
- `prefix |` - Vertical split
- `prefix -` - Horizontal split
- `prefix h/j/k/l` - Navigate panes

### Aerospace

- `alt-h/j/k/l` - Focus windows
- `alt-shift-h/j/k/l` - Move windows
- `alt-1..9` or `alt-a..z` - Switch workspace

## Theme

All configs use the [Nord](https://www.nordtheme.com/) color scheme.
