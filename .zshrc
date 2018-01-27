# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="tmuch"

CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
DISABLE_LS_COLORS="false"
DISABLE_AUTO_TITLE="false"
COMPLETION_WAITING_DOTS="false"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git tmux)

source $ZSH/oh-my-zsh.sh

export GIT_EDITOR='vim'
export EDITOR='vim'

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

if [ -f ~/.secrets ]; then
    source ~/.secrets
fi

alias ctags="`brew --prefix`/bin/ctags"
alias openx='find . -d 1 | grep xcodeproj | head -n 1 | xargs open --fresh --background'
alias gitp='git --no-pager'
alias diff='colordiff'

LESSPIPE=`which src-hilite-lesspipe.sh`
export LESSOPEN="| ${LESSPIPE} %s"
export LESS=' -R -X -F '

export PATH=$PATH:$USER/bin

ff() {
    FILE=`fzf $@`
    if [[ -e $FILE ]]; then
        echo $FILE
        echo -n $FILE | pbcopy
    fi
}

set rtp+=/usr/local/opt/fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
