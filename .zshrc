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
fi

################################################
# secrets
################################################
if [ -f ~/.secrets ]; then
    . ~/.secrets
fi

. "$HOME/.cargo/env"

###########################
# Prompt
###########################
__ssh_hostname_prompt(){
    if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
        echo "($(hostname)) "
    fi
}

autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '(%b)'
zstyle ':vcs_info:*' enable git

PS1='%F{119}%~
> %F{reset}'
RPS1='%F{244}[%D{%-m/%-f/%y} %D{%L:%M:%S} $(date +%Z)]%F{reset} %F{145}$(__ssh_hostname_prompt) %F{119}${vcs_info_msg_0_}%F{145}'

################################################
# macOS specific stuff
################################################
if [[ $(uname) == "Darwin" ]]; then
    source "/usr/local/opt/fzf/shell/completion.zsh"
    source "/usr/local/opt/fzf/shell/key-bindings.zsh"
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi

###########################
# Other settings
###########################
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# Enable menu-driven completion
zstyle ':completion:*' menu select

# Enable caching
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zcache

zstyle ':completion:*' completer _complete

# Case-insensitive completion for files
# _ = -
# Case-insensitive partial-word and substring completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{_-}={_-}' 'r:|=*' 'l:|=* r:|=*'

# Initialize completion system
autoload -U compinit && compinit
zmodload -i zsh/complist

# On an ambiguous completion, instead of listing possibilities or beeping, insert the first match immediately.
# Then when completion is requested again, remove the first match and insert the second match, etc.
# When there are no more matches, go back to the first one again. Enabling this setting overrides auto_menu.
unsetopt menu_complete

# If set, parameter expansion, command substitution and arithmetic expansion are performed in prompts. Substitutions within prompts do not affect the command status.
setopt prompt_subst

# If a completion is performed with the cursor within a word, and a full completion is inserted, the cursor is moved to the end of the word. That is, the cursore is moved to the end of the word if either a single match is inserted or menu completion is performed.
setopt always_to_end

# If this is set, zsh sessions will append their history list to the history file, rather than replace it. Thus, multiple parallel zsh sessions will all have the new entries from their history lists added to the history file, in the order that they exit. The file will still be periodically re-written to trim it when the number of lines grows 20% beyond the value specified by $SAVEHIST
setopt append_history

# Automatically use menu completion after the second consecutive request for completion, for example by pressing the tab key repeatedly.
setopt auto_menu

# If unset, the cursor is set to the end of the word if completion is started. Otherwise it stays there and completions is done from both ends.
setopt complete_in_word

# Save each command's beginning timestamp (in seconds since the epoch) and the duration (in seconds) to the history file.
setopt extended_history

# If a new command line being added to the history list duplicates an older one, the older command is removed from the list.
setopt hist_ignore_all_dups

# Whenever the user enters a line with history expansion, don't execute the line directly; instead, perform history expansion and reload the line into the editing buffer
setopt hist_verify

# New history lines are added to the $HISTFILE incrementally (as soon as they're entered), rather than waiting until the shell exits.
setopt inc_append_history

# Share history accros all session rather than waiting for a new shell invocation
setopt share_history

# Allow comments even in interactive shells
setopt interactivecomments

# Don't treat '#', '~', and '^' as characters part of patterns for filename generation, etc.
unsetopt extended_glob

# If a command is issued that can't be executed as a normal command, and the
# command is the name of a directory, perform a 'cd' to that directory
setopt auto_cd

# Push the old directory onto the directory stack when cd'ing
setopt auto_pushd

# Do not print the directory stack after pushd or popd
setopt pushd_silent

# Disallow '>' redirection to overwrite existing files.
# '>|' or '>!' must be used to overwrite a file.
setopt no_clobber

# Send the HUP signal to running jobs when the shell exits
unsetopt hup

# Make globbing (filename generation) case insensitive
unsetopt case_glob

# Don't beep on an ambiguous completion
unsetopt list_beep

# Start typing + [Up-Arrow] - prefix-match history forward
autoload -U up-line-or-beginning-search
zle -N up-line-or-beginning-search
bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search

# Start typing + [Down-Arrow] - prefix-match history backward
autoload -U down-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# Source goto
[[ -s "/usr/local/share/goto.sh" ]] && source /usr/local/share/goto.sh

################################################
# Launch tmux if in ssh session
################################################
if [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" != "" ]; then
    tmux attach-session -t ssh_tmux || tmux new-session -s ssh_tmux
fi

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
