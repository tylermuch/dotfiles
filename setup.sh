#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
platform=`uname`

if [[ $platform == "Darwin" && "$SHELL" != "/bin/zsh" ]]; then
	chsh -s /bin/zsh $USER
	echo "Set default shell to zsh. Restart terminal."
	exit 0
elif [[ $platform == "Linux" && "$SHELL" != "/bin/zsh" ]]; then
	sudo apt-get install zsh
	chsh -s /bin/zsh $USER
	echo "Set default shell to zsh. Restart terminal."
	exit 0
fi

if [[ $platform == 'Darwin' ]]; then
	if [ ! -d /usr/local/Cellar ]; then
		echo "Installing Homebrew"
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi

	brew update
	brew bundle -v # install Brewfile
	brew doctor
fi

echo "Copying dotfiles to ~/"
cp .bash* ~/
cp .gitconfig ~/
cp .zshrc ~/


echo "Installing prezto"
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
/bin/zsh -c 'setopt EXTENDED_GLOB'
/bin/zsh -c 'for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"; done'

cp prompt_tmuch_setup ~/.zprezto/modules/prompt/functions/
cp .zpreztorc ~/

# Install pip
echo "Installing pip..."
if hash pip 2>/dev/null; then
	echo "pip already installed, exiting..."
	exit
else
	python get-pip.py
fi

echo "Install ctags..."
if [[ $platform == 'Darwin' ]]; then
	brew install ctags
	echo "alias ctags=\"`brew --prefix`/bin/ctags\"" >> ~/.bash_aliases
elif [[ $platform == 'Linux' ]]; then
	sudo apt-get install exuberant-ctags cscope
fi

echo "Installing Vim bundles..."
if [ -d "$DIR/.vim/bundle/Vundle.vim" ]; then
	cp -R "$DIR/.vim" ~/
	cp "$DIR/.vimrc" ~/
	vim -c 'PluginInstall' -c 'qa!'
	#ln -s ~/.vim/bundle/cscope_maps/plugin ~/.vim/bundle/cscope_maps.vim
else
	echo "Vundle plugin bundle not found in repo."
	echo "Run: git submodule update --init --recursive"
fi

echo "Restart terminal"
