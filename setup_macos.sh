#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Installing homebrew..."
$DIR/brew.sh

echo "Setting up vim..."
$DIR/vimupdate.sh

echo "Setting up tmux..."
$DIR/tmuxsetup.sh

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

# Prevent system sleep when remote session is active
sudo pmset -c ttyskeepawake 1

# Suppress pop-ups when devices in Recovery Mode are attached
defaults write com.apple.MobileDeviceUpdater Disabled -bool YES
defaults write com.apple.iTunes dontAutomaticallySyncIPods -int 1
defaults write com.apple.iTunesHelper ignore-devices 1
defaults write com.apple.iTunes ignore-devices 1
defaults write com.apple.AMPDeviceDiscoveryAgent ignore-devices 1
defaults write com.apple.AMPDeviceDiscoveryAgent reveal-devices 0
