#!/usr/bin/env bash
# File: install.sh

my_pkg_list=( 
    bat
    git 
    stow
    tmux
    vim 
    zsh 
)

my_os=$(uname -s)

# Install function
install_packages() {
    local os=$1
    local pkg_list=("${!2}")

    case $os in
        'Linux')
            if [ -x "$(command -v apt)" ]; then
                # Debian-based Linux (e.g., Ubuntu)
                echo "### You are using Debian-based Linux"
                sudo apt update && sudo apt install -y "${pkg_list[@]}"
            else
                echo "### Unsupported Linux distribution"
                exit 1
            fi
            ;;

        'FreeBSD')
            if [ -x "$(command -v pkg)" ]; then
                echo "### You are using FreeBSD"
                sudo pkg update && sudo pkg install -y "${pkg_list[@]}"
            else
                echo "### Unsupported OS (FreeBSD with pkg not found)"
                exit 1
            fi
            ;;

        'Darwin')
            echo "### You are using macOS"
            ;;

        *)
            echo "### You are using an unsupported OS, $my_os"
            exit 1
            ;;
    esac
}

# Test for the platform and install packages accordingly
install_packages "$my_os" my_pkg_list

# Create structure for .config files
echo "### Creating working .config structure"
mkdir -p "$HOME/.config/{zsh,git,vim}"

# Stow .dotfiles
echo "### Creating symlink using Stow"
cd ~/.dotfiles || exit 1
stow -vSt ~ git tmux vim zsh

# Updating shell to zsh for the user
echo "### Updating shell to zsh"
chsh -s "$(command -v zsh)" "$USER"

if [ "$my_os" == 'Darwin' ]; then
    # Additional setup for macOS
    echo "### Creating working .config structure for asdf"
    mkdir -p "$HOME/.config/asdf"
    
    # Source macOS.sh to make it more usable
    echo "### Sourcing macOS.sh script"
    source ./macOS.sh
    
    # Install Homebrew
    echo "### Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "### Installation completed"
echo "### Consider running 'exec zsh -l' to load zsh now, or log out"
