################################################
# Bash aliases
################################################
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

################################################
# tmux helpers
################################################
tmux_windows()
{
    tmux list-windows -t dev | cut -d' ' -f2 | sed -E 's/(\*|-)$//'
}

tmux_window_index()
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
    if tmux_windows | grep -w ${1} > /dev/null; then
        echo "Window with that name already exists."
    else
        session_id=`tmux new-window -P -d -t dev -n "${1}"`
        tmux attach -t ${session_id}
    fi

}

# tmux windows
# cleanly list all tmux windows
tw() {
    tmux_windows
}

# tmux open
# open tmux window with the given name
# $1 = window name
to() {
    window_index=$(tmux_window_index "${1}")

    if [[ "$window_index" == "-1" ]];
    then
        echo "Window not found:"
        tmux_windows
    else
        tmux select-window -t "dev:${window_index}"
        tmux attach -t dev
    fi
}


################################################
# bash secrets
################################################
if [ -f ~/.bash_secrets ]; then
    . ~/.bash_secrets
fi

