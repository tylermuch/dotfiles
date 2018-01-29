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

if [[ "$SHELL" != "/usr/local/bin/zsh" ]]; then
    echo "Setting zsh as default shell..."
    echo "Add /usr/local/bin/zsh to /etc/shells"
    echo "(Press enter to continue)"
    echo "sudo vim /etc/shells"
    read
    sudo vim /etc/shells
    chsh -s /usr/local/bin/zsh $USER
fi

#    oh-my-zsh will install its own ~/.zshrc
#    so we need to install it before we symlink our dotfiles
#
echo "Installing oh-my-zsh..."
if [ ! -d $HOME/.oh-my-zsh ]; then
    ZSH_CUSTOM=$HOME/.oh-my-zsh/custom
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    mkdir $ZSH_CUSTOM/themes
    symlink $DIR/.oh-my-zsh/tmuch.zsh-theme $ZSH_CUSTOM/themes/tmuch.zsh-theme
fi

ln -sf $DIR/.zshrc $HOME/.zshrc
