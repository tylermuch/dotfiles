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

################################################
# Misc.
################################################
export GIT_EDITOR='vim'
export EDITOR='vim'
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

################################################
# macOS specific stuff
################################################
if [[ $(uname) == "Darwin" ]]; then
    alias ctags="`brew --prefix`/bin/ctags"
    alias openx='find . -d 1 | grep xcodeproj | head -n 1 | xargs open --fresh --background'
    alias subl="/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"
    
    ff() {
        FILE=`fzf $@`
        if [[ -e $FILE ]]; then
            echo $FILE
            echo -n $FILE | pbcopy
        fi
    }

    if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
        export PATH="$PATH:/usr/local/opt/fzf/bin"
        set rtp+=/usr/local/opt/fzf
        [[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.bash" 2> /dev/null
        source "/usr/local/opt/fzf/shell/key-bindings.bash"
    fi
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

################################################
# secrets
################################################
if [ -f ~/.secrets ]; then
    . ~/.secrets
fi

