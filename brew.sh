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

brew cleanup
