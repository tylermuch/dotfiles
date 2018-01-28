#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

declare -a FILES_TO_SYMLINK=(
    '.bash_profile'
    '.bashrc'
    '.bashrc_macos'
    '.gitconfig'
    '.tmux.conf'
    '.vimrc'
    '.zshrc'
)

for i in ${FILES_TO_SYMLINK[@]}; do
    src=$DIR/$i
    dest=$HOME/$i
    
    echo "Symlinking $src to $dest"
    ln -sf $src $dest
done
