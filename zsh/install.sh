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

#    oh-my-zsh will install its own ~/.zshrc
#    so we need to install it before we symlink our dotfiles
#
echo "Installing oh-my-zsh..."
if [ ! -d $HOME/.oh-my-zsh ]; then
    ZSH_CUSTOM=$HOME/.oh-my-zsh/custom

    if [[ $(uname) == "Linux" ]]; then
        sudo apt-get install curl
    fi

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    mkdir $ZSH_CUSTOM/themes
    ln -sf $DIR/.oh-my-zsh/tmuch.zsh-theme $ZSH_CUSTOM/themes/tmuch.zsh-theme
fi

ln -sf $DIR/.zshrc $HOME/.zshrc
