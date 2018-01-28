#! /bin/bash

# Exit upon command failure
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [[ $(uname) == "Darwin" ]]; then
    # Install Homebrew first
    $DIR/macOS/brew/install.sh

    for installer in $DIR/macOS/*/install.sh ; do
        if [[ "$installer" == "$DIR/macOS/brew/install.sh" ]]; then  continue; fi
        bash "$installer"
    done

    # Apply settings
    $DIR/macOS/settings.sh
fi

for installer in $DIR/*/install.sh ; do
    bash "$installer"
done

echo "Installation complete!"
