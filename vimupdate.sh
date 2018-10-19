#!/usr/bin/env bash

repos=(
    # vim-pathogen
    #     vim plugin manager
    
    tpope/vim-pathogen
    # vim-fugitive
    #     git commands
    #   
    #     :Gdiff
    #     :Gblame
    tpope/vim-fugitive

    # vim-commentary
    #     comment lines
    #
    #     gcc - toggle comment
    #     gc - toggle comment on visual selection
    tpope/vim-commentary

    # nerdtree
    #     file explorer pane
    #
    #     :NERDTreeToggle
    scrooloose/nerdtree

    # vim-airline
    #     nice looking and useful status line
    vim-airline/vim-airline

    # jellybeans
    #     my favorite theme
    nanotech/jellybeans.vim

    # tagbar
    #     browse symbols in file
    #
    #     :Tagbar   nmap = F8
    majutsushi/tagbar

    # vim-multiple-cursors
    #     sublime text style multiple cursors
    #
    #     Ctrl-n to select current word, repeat to select next occurances.
    #     Ctrl-p to undo selection
    #     Ctrl-x to skip to next possible selection
    terryma/vim-multiple-cursors

    # fzf.vim
    #     fzf in vim
    #
    #     :Files      Search file names, nmap = ;
    #     :Buffers    Search vim buffers, nmap = b
    #     :Lines      Search lines in buffer, nmap = l
    #     :Ag         Search file content, nmap = f
    junegunn/fzf.vim

    # vim-polyglot
    #     collection of language packs for syntax highlighting
    sheerun/vim-polyglot

    # vim-airline-themes
    #     airline themes
    vim-airline/vim-airline-themes

    # cscope_maps
    #     cscope tags
    #
    #     Ctrl-\ s    View references of symbol
    gnattishness/cscope_maps

    # goyo
    #     hide all vim window elements
    #
    #     :Goyo   nmap = F7
    junegunn/goyo.vim

    # limelight
    #     highlight only current block/paragraph of code/text
    #
    #     :Limelight  nmap = F6
    junegunn/limelight.vim

    jremmen/vim-ripgrep
)

set -e
dir=$HOME/.vim/bundle

# back up old bundle directory
if [ -d $dir -a -z "$1" ]; then
    temp="$(mktemp -d -t bundleXXXX)"
    echo "Moving old bundle dir to $temp"
    mv "$dir" "$temp"
fi

mkdir -p $dir

for repo in ${repos[@]}; do
    if [ -n "$1" ]; then
        if ! (echo "$repo" | grep -i "$1" &>/dev/null) ; then
            continue
        fi
    fi

    plugin="$(basename $repo | sed -e 's/\.git$//')"
    dest="$dir/$plugin"
    (
        git clone --depth=1 -q https://github.com/$repo $dest
        rm -rf $dest/.git
        echo "Cloned $repo"
    ) &

done

set +e

wait
