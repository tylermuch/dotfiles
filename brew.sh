#!/usr/bin/env bash

if [[ $(command -v brew) == "" ]]; then
    echo "Downloading and installing homebrew..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew install ssh-copy-id
brew install git
brew install tig
brew install wget
brew install watch
brew install ctags
brew install the_silver_searcher
brew install tree
brew install fzf
brew install colordiff
brew install vim
brew install tmux
brew install ansifilter
brew install zsh

brew cask install --appdir="/Applications" caffeine
brew cask install --appdir="/Applications" flux
brew cask install --appdir="/Applications" iterm2
brew cask install --appdir="/Applications" alfred
brew cask install --appdir="/Applications" sublime-text
mkdir ~/bin
ln -sf "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" $HOME/bin/subl

brew cleanup
