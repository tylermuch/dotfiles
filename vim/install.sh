#! /bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Installing vim..."

if [[ $(uname) == "Darwin" ]]; then
    brew install vim
elif [[ $(uname) == "Linux" ]]; then
    sudo apt-get install vim
else
    echo "I don't know how to install vim."
    exit 1
fi

ln -sf $DIR/.vim $HOME/.vim
ln -sf $DIR/.vim/vimrc $HOME/.vimrc

bash $DIR/.vim/update.sh

