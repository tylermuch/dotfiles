#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

declare -a FILES_TO_SYMLINK=(
    '.gitconfig'
    '.vimrc'
    '.zshrc'
    '.hushlogin'
    '.lldbinit'
    '.gitignore_global'
)

for i in ${FILES_TO_SYMLINK[@]}; do
    src=$DIR/$i
    dest=$HOME/$i
    
    echo "Symlinking $src to $dest"
    ln -sf $src $dest
done

mkdir -p $HOME/.config
ln -sfn $DIR/nvim $HOME/.config/nvim
ln -sfn $DIR/tmux $HOME/.config/tmux
ln -sf $DIR/tmux/.tmux.conf $HOME/.tmux.conf
ln -sfn $DIR/alacritty $HOME/.config/alacritty
