#! /bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Installing bash dotfiles..."
ln -sf $DIR/.bashrc $HOME/.bashrc
ln -sf $DIR/.bash_profile $HOME/.bash_profile

