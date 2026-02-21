#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

declare -a FILES_TO_SYMLINK=(
    '.gitconfig'
    '.tmux.conf'
    '.vimrc'
    '.zshrc'
    '.hushlogin'
    '.lldbinit'
    '.gitignore_global'
    '.alacritty.toml'
)

for i in ${FILES_TO_SYMLINK[@]}; do
    src=$DIR/$i
    dest=$HOME/$i
    
    echo "Symlinking $src to $dest"
    ln -sf $src $dest
done

mkdir -p $HOME/.config
ln -sf $DIR/nvim $HOME/.config/nvim
