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
COMPLETION_WAITING_DOTS="false"

# If this is false, tmux windows will be automatically renamed as well
# This ends up overriding the expected behavior of the -n flag to tmux new-window
# tmux new-window -n <window name>
DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git tmux)

source $ZSH/oh-my-zsh.sh

###########################
# Source .bashrc
###########################
source ~/.bashrc
