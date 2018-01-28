#! /usr/bin

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Installing git dotfiles..."

ln -sf $DIR/.gitconfig.base $HOME/.gitconfig
