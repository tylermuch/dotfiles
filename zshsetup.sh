#! /usr/bin/env bash

ZSH_EXPECTED_DIR=$(command -v zsh)
if [[ "$SHELL" != "$ZSH_EXPECTED_DIR" ]]; then
    echo "Setting zsh as default shell..."
    echo "Adding $ZSH_EXPECTED_DIR to /etc/shells"
    echo "$ZSH_EXPECTED_DIR" | sudo tee -a /etc/shells
    chsh -s "$ZSH_EXPECTED_DIR" "$USER"
fi

