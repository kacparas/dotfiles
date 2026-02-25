#!/bin/bash

# Dotfiles installation script
# Creates symlinks from home directory to dotfiles repo

set -e

DOTFILES_DIR="$HOME/repos/dotfiles"

echo "Installing dotfiles from $DOTFILES_DIR"

# Install Homebrew packages
echo "Installing Homebrew packages..."
brew bundle --file="$DOTFILES_DIR/Brewfile"

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
link_file "$DOTFILES_DIR/yatoro" "$HOME/.config/Yatoro"

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
echo "  - Run 'tmux source ~/.config/tmux/tmux.conf' to reload tmux"
echo "  - Restart terminal for zsh changes"
echo "  - For new Obsidian vaults, run: setup-obsidian-vault <vault-path>"

# Function to setup Obsidian vault with template config
setup_obsidian_vault() {
    local vault_path="$1"
    if [ -z "$vault_path" ]; then
        echo "Usage: setup-obsidian-vault <vault-path>"
        return 1
    fi

    mkdir -p "$vault_path/.obsidian"
    cp -r "$DOTFILES_DIR/obsidian-template/.obsidian/"* "$vault_path/.obsidian/"
    echo "Obsidian config copied to $vault_path"
    echo "Open vault in Obsidian and install community plugins from the list"
}
