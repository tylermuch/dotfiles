basedir=$HOME/.dotfiles
bindir=$HOME/bin
repourl=https://github.com/tylermuch/dotfiles

set -e

function symlink() {
    src=$1
    dest=$2

    if [ -e $dest ]; then
        if [ -L $dest ]; then
            # Already symlinked -- I'll assume correctly
            return
        else
            # Rename files with a ".old" extension
            echo "$dest already exists, renaming to $dest.old"
            backup=$dest.old
            if [ -e $backup ]; then
                echo "Error: $backup already exists. Please delete or rename it."
                exit 1
            fi
            mv -v $dest $backup
        fi
    fi

    ln -sf $src $dest
}

if ! which git >/dev/null ; then
    echo "Error: git is not installed"
    exit 1
fi

echo "Updating dotfiles..."
if [ -d $basedir/.git ]; then
    echo "Updating dotfiles using existing git.."
    #git -C $basedir pull --quiet --rebase origin master
else
    echo "Checking out dotfiles using git..."
    rm -rf $basedir
    git clone --quiet --depth=1 $repourl $basedir
fi

#    oh-my-zsh will install its own ~/.zshrc
#    so we need to install it before we symlink our dotfiles
#
echo "Installing oh-my-zsh..."
if [ ! -d $HOME/.oh-my-zsh ]; then
    ZSH_CUSTOM=$HOME/.oh-my-zsh/custom
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    mkdir $ZSH_CUSTOM/themes
    symlink $basedir/.oh-my-zsh/tmuch.zsh-theme $ZSH_CUSTOM/themes/tmuch.zsh-theme
fi

echo "Creating symlinks..."
cd $basedir
for path in .* ; do
    case $path in
        .|..|.git*|.oh-my-zsh)
            continue
            ;;
        *)
            symlink $basedir/$path $HOME/$path
            ;;
    esac
done

symlink $basedir/.vim/vimrc $HOME/.vimrc

echo "Setting up Git..."
symlink $basedir/.gitconfig.base $HOME/.gitconfig

echo "Installing Homebrew modules..."
if [ ! -d /usr/local/Cellar ]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    set +e
    brew update
    brew bundle -v # Install Brewfile
    brew doctor
    set -e
fi

echo "Installing Vim plugins..."
$basedir/.vim/update.sh

echo "Install tmux plugins..."
if [ ! -d $HOME/.tmux/plugins/tpm ]; then
    mkdir -p $HOME/.tmux/plugins
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
fi

if [[ "$SHELL" != "/usr/local/bin/zsh" ]]; then
    echo "Setting zsh as default shell..."
    echo "Add /usr/local/bin/zsh to /etc/shells"
    echo "(Press enter to continue)"
    echo "sudo vim /etc/shells"
    read
    sudo vim /etc/shells
    chsh -s /usr/local/bin/zsh $USER
fi

# Various other settings
defaults write NSGlobalDomain KeyRepeat -int 1 # Faster key repeat than is allowed from System Preferences

echo "Installation complete!"
