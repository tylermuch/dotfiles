repos=(
    gnattishness/cscope_maps
    tpope/vim-fugitive
    tpope/vim-pathogen
    tpope/vim-commentary
    scrooloose/nerdtree
    jistr/vim-nerdtree-tabs
    vim-airline/vim-airline
    nanotech/jellybeans.vim
    majutsushi/tagbar
    terryma/vim-multiple-cursors
    junegunn/fzf.vim
    mileszs/ack.vim
    sheerun/vim-polyglot
    vim-airline/vim-airline-themes
    airblade/vim-gitgutter
)

set -e
dir=$HOME/.vim/bundle

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
