#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

declare -a FILES_TO_SYMLINK=(
    '.bash_profile'
    '.bashrc'
    '.gitconfig'
    '.tmux.conf'
    '.vimrc'
    '.zshrc'
    '.hushlogin'
)

for i in ${FILES_TO_SYMLINK[@]}; do
    src=$DIR/$i
    dest=$HOME/$i
    
    echo "Symlinking $src to $dest"
    ln -sf $src $dest
done
