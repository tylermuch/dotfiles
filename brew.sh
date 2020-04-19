#!/usr/bin/env bash

if [[ $(command -v brew) == "" ]]; then
    echo "Downloading and installing homebrew..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew install ssh-copy-id                 `# Copy ssh public key to remote system` \
             git                         `# Git` \
             tig                         `# Terminal based git browser` \
             wget                        `# Wget` \
             watch                       `# Periodically execute shell command` \
             ctags                       `# Generate source code tags for quick navigation` \
             ripgrep                     `# Much faster 'grep'` \
             tree                        `# Pretty print filesystem trees` \
             fzf                         `# Fuzzy file searcher` \
             colordiff                   `# Diff in color` \
             vim                         `# Vim` \
             tmux                        `# Tmux` \
             ansifilter                  `# Filter non-ascii characters` \
             zsh                         `# Preferred shell` \
             goto                        `# Quick file directory aliasing/navigation` \
             mosh                        `# UDP-based ssh. Good for unstable connections.` \
             fd                          `# Faster/prettier 'find'` \
             the_silver_searcher         `# Faster grep. Used for :Ag in vim until I figure out :Rg...` \
             bat                         `# Better 'cat'`

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
MOSH_SYMLINK=$(which mosh-server)
MOSH_CELLAR=$(brew --cellar mosh)/$(brew list --versions mosh | cut -d' ' -f2)/bin/mosh-server
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate off
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --add ${MOSH_SYMLINK}
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --unblockapp ${MOSH_SYMLINK}
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --add ${MOSH_CELLAR}
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --unblockapp ${MOSH_CELLAR}

brew cleanup
