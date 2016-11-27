#!/bin/bash

if [ "$SHELL" != "/bin/zsh" ]; then
	chsh -s /bin/zsh $USER
	echo "Set default shell to zsh. Restart terminal."
	exit 0
fi

if [ ! -d /usr/local/Cellar ]; then
	echo "Installing Homebrew"
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi


brew update
brew bundle -v # install Brewfile
brew doctor

echo "Copying dotfiles to ~/"
cp .bash* ~/
cp .gitconfig ~/
cp .zshrc ~/
cp .vimrc ~/
# Install prezto
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
fi

sudo easy_install pip

echo "Remember to disable mission control shortcuts"
echo "Restart terminal"
