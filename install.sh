#!/bin/bash

# Dotfiles installation script
# Creates symlinks from home directory to dotfiles repo

set -e

DOTFILES_DIR="$HOME/repos/dotfiles"

echo "Installing dotfiles from $DOTFILES_DIR"

# Install Homebrew packages
echo "Installing Homebrew packages..."
brew install poppler
brew install --cask obsidian

# Function to create symlink with backup
link_file() {
    local src="$1"
    local dest="$2"

    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        echo "Backing up $dest to $dest.bak"
        mv "$dest" "$dest.bak"
    elif [ -L "$dest" ]; then
        rm "$dest"
    fi

    echo "Linking $dest -> $src"
    ln -s "$src" "$dest"
}

# Create .config directory if it doesn't exist
mkdir -p "$HOME/.config"

# Link config directories
link_file "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
link_file "$DOTFILES_DIR/tmux" "$HOME/.config/tmux"
link_file "$DOTFILES_DIR/aerospace" "$HOME/.config/aerospace"
link_file "$DOTFILES_DIR/wezterm" "$HOME/.config/wezterm"
link_file "$DOTFILES_DIR/sketchybar" "$HOME/.config/sketchybar"

# Link zsh configs
link_file "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
link_file "$DOTFILES_DIR/zsh/.zprofile" "$HOME/.zprofile"

# Link Claude config
mkdir -p "$HOME/.claude"
link_file "$DOTFILES_DIR/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"

# Link MCP config
link_file "$DOTFILES_DIR/mcp/.mcp.json" "$HOME/.mcp.json"

echo ""
echo "Dotfiles installed successfully!"
echo ""
echo "Next steps:"
echo "  - Install Homebrew packages (see README)"
echo "  - Run 'tmux source ~/.config/tmux/tmux.conf' to reload tmux"
echo "  - Restart terminal for zsh changes"
