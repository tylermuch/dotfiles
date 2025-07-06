################################################
# PATH
################################################
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/local
export PATH=$PATH:/usr/libexec
export PATH=$PATH:/usr/sbin
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/bin/git-fuzzy/bin
export PATH=$PATH:/opt/homebrew/bin
export PATH=$PATH:$HOME/Library/Python/3.8/bin
export PATH=$PATH:$HOME/go/bin

################################################
# Aliases
################################################
alias mkdir='mkdir -pv'
alias ls='eza -lahb'
alias less='less -FSRXc'
alias gitp='git --no-pager'
alias diff='colordiff'
alias sudo='sudo ' # Enable aliases to be sudo'ed
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias which='which -a'
alias tmux='tmux -2'
alias cls="clear; printf '\e[3J'; clear"
alias vim='nvim'
alias clearall="printf '\033c'"
alias bfzf='git checkout $(git branch | fzf)'

################################################
# Misc.
################################################
export GIT_EDITOR='nvim'
export EDITOR='nvim'

if [[ $(uname) == "Darwin" ]]; then
export LSCOLORS=GxFxCxDxBxegedabagaced
export CLICOLOR=1
else
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
alias ls="ls --color"
fi
export TERM=xterm-256color
export BAT_THEME=Dracula
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

################################################
# macOS specific stuff
################################################
if [[ $(uname) == "Darwin" ]]; then
    alias ctags="`brew --prefix`/bin/ctags"
   
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

    fv() {
        vim `echo "$_FZF" | tr '\n' ' '`
    }

    ff() {
        _FZF_CMD="fzf -m"
        for var in "$@"
        do
          _FZF_CMD="$_FZF_CMD -q $var"
        done
        _FZF_TMP=`eval ${_FZF_CMD}`
        if [[ -n $_FZF_TMP ]]; then
            _FZF=$_FZF_TMP
            echo $_FZF
            export _FZF
        fi
    }

    if (( $+commands[tag] )); then
      export TAG_SEARCH_PROG=rg
      tag() { command tag "$@"; source ${TAG_ALIAS_FILE:-/tmp/tag_aliases} 2>/dev/null }
      alias rg=tag
    fi

    export PATH="$PATH:/usr/local/opt/fzf/bin"
    set rtp+=/usr/local/opt/fzf
fi    

################################################
# secrets
################################################
if [ -f ~/.secrets ]; then
    . ~/.secrets
fi

. "$HOME/.cargo/env"
