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
brew bundle # install Brewfile
brew doctor

echo "Copying dotfiles to ~/"
cp .bash* ~/
cp .gitconfig ~/

# Install prezto
echo "Installing prezto"
zsh
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
exit

cp prompt_tmuch_setup ~/.zprezto/modules/prompt/functions/
cp .zpreztorc ~/

# Set default shell to zsh
echo "Setting zsh to default shell..."
chsh -s /bin/zsh $USER

# Install pip
echo "Installing pip..."
sudo easy_install pip

