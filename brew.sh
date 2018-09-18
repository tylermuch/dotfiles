#!/usr/bin/env bash

if [[ $(command -v brew) == "" ]]; then
    echo "Downloading and installing homebrew..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew install ssh-copy-id            \
             git                    \
             tig                    \
             wget                   \
             watch                  \
             ctags                  \
             the_silver_searcher    \
             tree                   \
             fzf                    \
             colordiff              \
             vim                    \
             tmux                   \
             ansifilter             \
             reattach-to-user-namespace \
             zsh

brew cask install --appdir="/Applications" caffeine     \
                                           alfred       \
                                           sublime-text 
mkdir ~/bin
ln -sf "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" $HOME/bin/subl

brew cleanup
