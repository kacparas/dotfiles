# Dotfiles

Personal configuration files for macOS development environment.

## Contents

- **nvim** - Neovim configuration (lazy.nvim, Telescope, Neo-tree, Iron.nvim)
- **tmux** - Tmux with Nord theme and TPM plugins
- **aerospace** - Tiling window manager
- **wezterm** - Terminal emulator
- **sketchybar** - macOS status bar
- **zsh** - Shell configuration with Powerlevel10k

## Installation

### Prerequisites

Install these via Homebrew:

```bash
brew install neovim tmux git
brew install --cask wezterm
brew install nikitabobko/tap/aerospace
brew tap FelixKratz/formulae && brew install sketchybar
```

### Setup

1. Clone the repository:
```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/repos/dotfiles
```

2. Run the install script:
```bash
cd ~/repos/dotfiles
./install.sh
```

3. Install tmux plugins:
```bash
# Start tmux and press prefix + I (Ctrl-b I)
```

4. Install Neovim plugins:
```bash
nvim  # Lazy.nvim will auto-install plugins on first launch
```

## Key Bindings

### Neovim

- Leader: `Space`
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>e` - Toggle file explorer
- `<leader>rs` - Start Python REPL
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
