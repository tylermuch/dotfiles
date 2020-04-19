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
             ripgrep                \
             tree                   \
             fzf                    \
             colordiff              \
             vim                    \
             tmux                   \
             ansifilter             \
             reattach-to-user-namespace \
             zsh                    \
             goto                   \
             mosh                   \
             fd

brew cask install --appdir="/Applications" caffeine     \
                                           alfred       \
                                           sublime-text

# https://github.com/aykamko/tag
brew tap aykamko/tag-ag
brew install tag-ag

mkdir ~/bin
ln -sf "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" $HOME/bin/subl

# mosh-server firewall setup. Configuring this through the preferences GUI doesn't seem to work properly
# From https://github.com/mobile-shell/mosh/issues/898#issuecomment-368333946
alias firepower='sudo /usr/libexec/ApplicationFirewall/socketfilterfw'
MOSH_SYMLINK=$(which mosh-server)
MOSH_CELLAR=$(brew --cellar mosh)/$(brew list --versions mosh | cut -d' ' -f2)/bin/mosh-server
firepower --setglobalstate off
firepower --add ${MOSH_SYMLINK}
firepower --unblockapp ${MOSH_SYMLINK}
firepower --add ${MOSH_CELLAR}
firepower --unblockapp ${MOSH_CELLAR}

brew cleanup
