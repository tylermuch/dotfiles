export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="tmuch"

CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
DISABLE_LS_COLORS="false"
DISABLE_AUTO_TITLE="false"
COMPLETION_WAITING_DOTS="false"

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

ff() {
	FILE=`fzf $@`
	if [[ -e $FILE ]]; then
		echo $FILE
		echo -n $FILE | pbcopy
	fi
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
