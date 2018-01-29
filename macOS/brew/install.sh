#! /bin/bash

echo "Installing Homebrew..."

if [ ! -d /usr/local/Cellar ]; then
    echo "Downloading and installing homebrew..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    set +e
    echo "Installing my homebrew modules..."
    brew update
    brew bundle -v # Install Brewfile
    brew doctor
    set -e
fi
