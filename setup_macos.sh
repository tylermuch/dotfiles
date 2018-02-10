#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Installing homebrew..."
$DIR/brew.sh

echo "Setting up vim..."
$DIR/vimupdate.sh

echo "Installing zsh..."
$DIR/zshsetup.sh

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

# Enable three finger dragging windows
defaults write com.apple.AppleMultitouchTrackpad -bool true
