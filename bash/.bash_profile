# .bash_profile is executed for login shells, while .bashrc is executed for interactive non-login shells
# Source .bashrc for both
if [ -f ~/.dotfiles/bash/bashrc ]; then
  . ~/.dotfiles/bash/bashrc
fi
