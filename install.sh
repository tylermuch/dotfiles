#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

#
#   Install Homebrew
#
if [ ! -d /usr/local/Cellar ]; then
	echo "Installing Homebrew"
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew bundle -v # install Brewfile
brew doctor

#
#   Set zsh as default shell
#
if [[ "$SHELL" != "/usr/local/bin/zsh" ]]; then
    sudo vim /etc/shells
	chsh -s /usr/local/bin/zsh $USER
	echo "Set default shell to zsh. Restart terminal."
	exit 0
fi

#
# Install oh-my-zsh
#
ZSH_CUSTOM=$HOME/.oh-my-zsh/themes
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

#
# Copy dotfiles to $HOME
#
cp .gitconfig ~/
cp .zshrc ~/
cp tmuch.zsh-theme $ZSH_CUSTOM/themes/tmuch.zsh-theme

#
# Install pip
#
if hash pip 2>/dev/null; then
	echo "pip already installed, exiting..."
	exit
else
	python get-pip.py
fi

#
#   Install Vundle plugins
#
if [ -d "$DIR/.vim/bundle/Vundle.vim" ]; then
	cp -R "$DIR/.vim" ~/
	cp "$DIR/.vimrc" ~/
	vim -c 'PluginInstall' -c 'qa!'
	#ln -s ~/.vim/bundle/cscope_maps/plugin ~/.vim/bundle/cscope_maps.vim
else
	echo "Vundle plugin bundle not found in repo."
	echo "Run: git submodule update --init --recursive"
fi


defaults write NSGlobalDomain KeyRepeat -int 1

mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "Execute prefix+I in tmux to install tmux plugins"

echo "Restart terminal"
