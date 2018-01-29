#! /usr/bash

echo "Installing sublime text..."

if [[ $(uname) == "Darwin" ]]; then
    brew cask install --appdir="/Applications" sublime-text
    mkdir ~/bin
    ln -sf "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" ~/bin/subl
elif [[ $(uname) == "Linux" ]]; then
    sudo apt-get install sublime-text
    sudo ln -sf /opt/sublime/sublime_text /usr/bin/subl
else
    echo "I don't know how to install sublime text."
fi
