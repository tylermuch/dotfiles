#!/usr/bin/env bash

if [[ $(command -v brew) == "" ]]; then
    echo "Downloading and installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
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
             bat                         `# Better 'cat'` \
             git-delta                   `# Better git diffs` \
             exa                         `# Better 'ls'` \
             neovim                      `# Neovim` \
             nodejs                      `# For neovim plugins \
             difftastic                  `# Better diff

brew cask install --appdir="/Applications" caffeine      \
                                           alfred        \
                                           sublime-text  \
                                           sublime-merge \
                                           contexts

mkdir ~/bin
ln -sf "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" $HOME/bin/subl
ln -sf "/Applications/Sublime Merge.app/Contents/SharedSupport/bin/smerge" $HOME/bin/smerge

# https://github.com/aykamko/tag
brew tap aykamko/tag-ag
brew install tag-ag
#pushd /tmp
# If this fails, use the following
#wget https://go.dev/dl/go1.18.darwin-amd64.pkg
#sudo installer -pkg go1.18.darwin-amd64.pkg -target /
#popd

brew cleanup
