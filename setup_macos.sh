#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Installing homebrew..."
$DIR/brew.sh

echo "Setting zsh as default shell..."
ZSH_EXPECTED_DIR=$(command -v zsh)
if [[ "$SHELL" != "$ZSH_EXPECTED_DIR" ]]; then
    echo "Setting zsh as default shell..."
    echo "Adding $ZSH_EXPECTED_DIR to /etc/shells"
    echo "$ZSH_EXPECTED_DIR" | sudo tee -a /etc/shells
    chsh -s "$ZSH_EXPECTED_DIR" "$USER"
fi

echo "Setting up vim..."
$DIR/vimupdate.sh

echo "Symlinking dotfiles..."
$DIR/symlink.sh

echo "Setting macOS user defaults..."
defaults write com.apple.finder ShowPathBar -bool true
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# Key repeat
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 25

# Disable press-and-hold in favor of key-repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

