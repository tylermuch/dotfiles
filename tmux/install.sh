#! /bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Installing tmux..."

if [[ $(uname) == "Darwin" ]]; then
    brew install tmux
    brew install ansifilter # required for tmux-logging plugin
elif [[ $(uname) == "Linux" ]]; then
    sudo apt-get install tmux
else
    echo "I don't know how to install tmux."
    exit 1
fi

if [ ! -d $HOME/.tmux/plugins/tpm ]; then
    echo "Installing tmux plugin manager..."
    mkdir -p $HOME/.tmux/plugins
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
    echo "prefix + I in tmux to install plugins"
fi

ln -sf $DIR/.tmux.conf $HOME/.tmux.conf

