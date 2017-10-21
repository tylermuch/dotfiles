#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
platform=`uname`

if [[ $platform == 'Darwin' ]]; then
	if [ ! -d /usr/local/Cellar ]; then
		echo "Installing Homebrew"
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi

	brew update
	brew bundle -v # install Brewfile
	brew doctor
fi

if [[ $platform == "Darwin" && "$SHELL" != "/usr/local/bin/zsh" ]]; then
	chsh -s /usr/local/bin/zsh $USER
	echo "Set default shell to zsh. Restart terminal."
	exit 0
elif [[ $platform == "Linux" && "$SHELL" != "/bin/zsh" ]]; then
	sudo apt-get install zsh
	chsh -s /bin/zsh $USER
	echo "Set default shell to zsh. Restart terminal."
	exit 0
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "Copying dotfiles to ~/"
cp .bash* ~/
cp .gitconfig ~/

cp ~/.zshrc ~/.zshrc_oh_my_zsh
cp .zshrc ~/

mkdir $ZSH_CUSTOM/themes
cp tmuch.zsh-theme $ZSH_CUSTOM/themes/tmuch.zsh-theme

# Install pip
echo "Installing pip..."
if hash pip 2>/dev/null; then
	echo "pip already installed, exiting..."
	exit
else
	python get-pip.py
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
