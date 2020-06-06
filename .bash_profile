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
alias tmux='tmux -2'
alias cls="clear; printf '\e[3J'; clear"

################################################
# Misc.
################################################
export GIT_EDITOR='vim'
export EDITOR='vim'
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
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
        _FZF_TMP=`fzf -m $@`
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

