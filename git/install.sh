#! /usr/bin

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Installing git..."

if [[ $(uname) == "Darwin" ]]; then
    brew install git
elif [[ $(uname) == "Linux" ]]; then
    sudo apt-get install git
else
    echo "I don't know how to install git."
fi

ln -sf $DIR/.gitconfig.base $HOME/.gitconfig
