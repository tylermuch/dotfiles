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
             eza                         `# Better 'ls'` \
             neovim                      `# Neovim` \
             nodejs                      `# For neovim plugins` \
             pyenv                       `# Multiple python installations` \
             coreutils                   `# GNU coreutils. Mostly for 'timeout'` \
             pv                          `# Monitor progress of data through a pipe`

mkdir ~/bin
ln -sf "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" $HOME/bin/subl
ln -sf "/Applications/Sublime Merge.app/Contents/SharedSupport/bin/smerge" $HOME/bin/smerge

pushd /tmp
wget "https://go.dev/dl/$(curl 'https://go.dev/VERSION?m=text' | head -1).darwin-arm64.pkg"
sudo installer -pkg $(curl 'https://go.dev/VERSION?m=text' | head -1).darwin-arm64.pkg -target /
popd

brew cleanup
