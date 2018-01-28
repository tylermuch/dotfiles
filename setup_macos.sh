#! /bin/bash

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
