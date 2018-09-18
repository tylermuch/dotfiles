################################################
# PATH
################################################
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/local
export PATH=$PATH:/usr/libexec
export PATH=$PATH:/usr/sbin
export PATH=$PATH:$USER/bin

################################################
# Aliases
################################################
alias mkdir='mkdir -pv'
alias l='ls -FGlAhp'
alias less='less -FSRXc'
alias gitp='git --no-pager'
alias diff='colordiff'
alias sudo='sudo ' # Enable aliases to be sudo'ed
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias which='which -a'

################################################
# Misc.
################################################
export GIT_EDITOR='vim'
export EDITOR='vim'
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export TERM=xterm-256color

################################################
# macOS specific stuff
################################################
if [[ $(uname) == "Darwin" ]]; then
    alias ctags="`brew --prefix`/bin/ctags"
    alias ag='ag --ignore cscope.out --ignore tags'
   
    openx() {
        XCODE_PATH=$(dirname "$(dirname "$(xcode-select -p)")")
        printf '\e[33m%s\e[0m\n' "-- $(basename "$(dirname "$XCODE_PATH")")/$(basename "$XCODE_PATH") --"

        if [ -z "$1" ]; then
            DIR=$(basename "$(pwd)")
            if [ -d "$DIR".xcodeproj ]; then
                open -F -a "$XCODE_PATH" "$DIR".xcodeproj
            else
                find . -name '*.xcodeproj' -maxdepth 1 | head -n 1 | xargs open -F -a "$XCODE_PATH"
            fi
        else
            DIR=$(basename "$1")
            if [ -d "$1"/"$DIR".xcodeproj ]; then
                open -F -a "$XCODE_PATH" "$1"/"$DIR".xcodeproj
            else
                find "$1" -name '*.xcodeproj' -maxdepth 1 | head -n 1 | xargs open -F -a "$XCODE_PATH"
            fi
        fi
    }

    subl() {
        "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" "$@"
    }

    fv() {
        vim `echo "$_FZF_LAST" | tr '\n' ' '`
    }

    ff() {
        _FZF_LAST=`fzf -m $@`
        if [[ -n $_FZF_LAST ]]; then
            echo $_FZF_LAST
            export _FZF_LAST
        else
            unset _FZF_LAST
        fi
    }

    export PATH="$PATH:/usr/local/opt/fzf/bin"
    set rtp+=/usr/local/opt/fzf
fi    

################################################
# tmux helpers
################################################
__tmux_windows()
{
    tmux list-windows -t dev | cut -d' ' -f2 | sed -E 's/(\*|-)$//'
}

__tmux_window_index()
{
    # $1 = window name
    # prints window index

    windows=$(tmux list-windows -t dev | cut -d' ' -f1,2 | sed -E 's/(\*|-)$//')
    window_indicies=$(echo "${windows}" | cut -d: -f1)
    window_names=$(echo "${windows}" | cut -d' ' -f2 | sed -E 's/(\*|-)$//')
    list_index=$(echo "${window_names}" | grep -n ${1} | cut -d: -f1)
    if [[ "${list_index}" == "" ]]; then
        echo "-1"
        return
    fi

    window_index=$(echo "${window_indicies}" | sed -n ${list_index}p)
    echo "${window_index}"
}

# tmux new
# create new tmux window in existing dev session
# $1 = window name
tn() {
    if __tmux_windows | grep -w ${1} > /dev/null; then
        echo "Window with that name already exists."
    else
        session_id=`tmux new-window -P -d -t dev -n "${1}"`
        tmux attach -t ${session_id}
    fi

}

# tmux windows
# cleanly list all tmux windows
tw() {
    __tmux_windows
}

# tmux open
# open tmux window with the given name
# $1 = window name
to() {
    window_index=$(__tmux_window_index "${1}")

    if [[ "$window_index" == "-1" ]];
    then
        echo "Window not found:"
        __tmux_windows
    else
        tmux select-window -t "dev:${window_index}"
        tmux attach -t dev
    fi
}

ta() {
    tmux attach -t $@
}

# 'rg ssh' -> 'rg ssh .'
# so that file paths are appended with './'
# this helps tmux-copy recognize the file path in a search
rg() {
    /usr/local/bin/rg $@ .
}

################################################
# secrets
################################################
if [ -f ~/.secrets ]; then
    . ~/.secrets
fi

