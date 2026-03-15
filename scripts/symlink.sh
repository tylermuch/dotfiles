#!/usr/bin/env bash

# Get the directory of the script
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Move up one level to the root of the dotfiles repo
DOTFILES_ROOT="$(dirname "$DIR")"

echo "Stowing dotfiles..."
cd "$DOTFILES_ROOT"

# List of packages to stow
PACKAGES=(
    git
    zsh
    vim
    lldb
    shell
    nvim
    tmux
    alacritty
    ghostty
)

for pkg in "${PACKAGES[@]}"; do
    echo "Stowing $pkg..."
    # -v: verbose, -R: recursive, -t ~: target home directory
    stow -v -R "$pkg" -t "$HOME"
done
