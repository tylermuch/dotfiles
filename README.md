# dotfiles

macOS setup for terminal and editor configuration.

## Setup

```sh
./setup_macos.sh
```

This installs Homebrew packages, sets up symlinks, configures tmux, sets zsh as the default shell, and installs Rust/Cargo tools.

## After setup

Install tmux plugins by opening tmux and pressing `prefix + I`.

## Private config

Secrets go in `~/.secrets` (sourced automatically, not tracked).

Git config for private/work repos goes in `~/.gitconfig.private` (not tracked). Example:

```ini
[includeIf "gitdir:~/src/"]
  path = ~/.gitconfig.private.internal
```

