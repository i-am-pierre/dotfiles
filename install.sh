#!/bin/bash
# File: install.sh

# Define package list
pkg_list=( 
    bat
    git
    pwgen 
    stow
    tmux
    vim 
    zsh 
)

# Get Current directory instead of hardcoded path
MY_DOT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Function to install packages
install_packages() {
    local package_manager="$1"
    shift
    echo "### You are using $package_manager"

    if [ -x "$(command -v $package_manager)" ]; then
        sudo $package_manager update && sudo $package_manager install -y "${pkg_list[@]}" || { echo "Failed to install packages"; exit 1; }
    else
        echo "### $package_manager not found. Please install it."
        exit 1
    fi
}

# Get OS information
my_os=$(uname -s)

case $my_os in
    'Linux')
        install_packages apt
        ;;
    'FreeBSD')
        install_packages pkg
        ;;
    'Darwin')
        echo "### You are using macOS"
        if ! [ -x "$(command -v brew)" ]; then
            # Install Homebrew if it's not already installed
            echo "### Installing Homebrew"
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || { echo "Failed to install Homebrew"; exit 1; }
        fi

        # Add brew to PATH temporarily
        echo "### Adding brew to PATH temporarily"
        eval "$(/opt/homebrew/bin/brew shellenv)"

        # Then pass in the Brewfile location...
        echo "### Installing content of the Brewfile"
        brew bundle --file "$MY_DOT_DIR"/Brewfile
    
        # Source macOS.sh to make it more usable
        echo "### Sourcing macOS.sh script"
        source "$MY_DOT_DIR"/scripts/macOS.sh || { echo "Failed to source macOS.sh"; exit 1; }
        ;;
    *)
        echo "### You are using an unsupported OS, $my_os"
        exit 1
        ;;
esac

# Create structure for .config files
echo "### Creating working .config structure"
mkdir -p "$HOME"/.config/{zsh,git,vim}

# Stow .dotfiles
echo "### Creating symlink using Stow"
if [ -x "$(command -v stow)" ]; then
    stow -vSt "$HOME" git tmux vim zsh || { echo "Failed to stow dotfiles"; exit 1; }
else
    echo "Stow not found. Please install it."
fi

# Structure and simlink for asdf on macOS
if [[ $my_os == Darwin ]]; then
    # Create structure for .config files for asdf
    echo "### Creating working .config structure for asdf"
    mkdir -p "$HOME"/.config/asdf

    # Stow .dotfile asdf only
    echo "### Creating symlink using Stow"
    if [ -x "$(command -v stow)" ]; then
        stow -vSt "$HOME" asdf || { echo "Failed to stow dotfiles"; exit 1; }
    else
        echo "Stow not found. Please install it."
    fi
fi

# Updating shell to zsh for the user
echo "### Updating shell to zsh"
chsh -s "$(command -v zsh)" "$USER" || { echo "Failed to update shell to zsh"; exit 1; }

echo "### Installation completed"
echo "### Consider running 'exec zsh -l' to load zsh now, or log out"
