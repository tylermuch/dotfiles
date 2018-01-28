#! /bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Installing zsh..."

if [[ $(uname) == "Darwin" ]]; then
    brew install zsh
elif [[ $(uname) == "Linux" ]]; then
    sudo apt-get install zsh
else
    echo "I don't know how to install zsh"
fi

ZSH_EXPECTED_DIR=$(command -v zsh)
if [[ "$SHELL" != "$ZSH_EXPECTED_DIR" ]]; then
    echo "Setting zsh as default shell..."
    echo "Adding $ZSH_EXPECTED_DIR to /etc/shells"
    echo "$ZSH_EXPECTED_DIR" | sudo tee -a /etc/shells
    chsh -s "$ZSH_EXPECTED_DIR" "$USER"
fi

ln -sf $DIR/zshrc $HOME/.zshrc
