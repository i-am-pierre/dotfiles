#!/bin/bash
# File: install.sh

my_pkg_list=( 
    bat
    git
    pwgen 
    stow
    tmux
    vim 
    zsh 
)

my_os=$(uname -s)  # Corrected variable name

case $my_os in  # Corrected variable name
    'Linux')
        if [ -x "$(command -v apt)" ]; then
            # Debian-based Linux (e.g., Ubuntu)
            echo "### You are using Debian-based Linux"
            sudo apt update && sudo apt install -y "${my_pkg_list[@]}" || { echo "Failed to install packages"; exit 1; }
        else
            echo "### Unsupported Linux distribution"
            exit 1
        fi
        ;;

    'FreeBSD')
        if [ -x "$(command -v pkg)" ]; then
            echo "### You are using FreeBSD"
            sudo pkg update && sudo pkg install -y "${my_pkg_list[@]}" || { echo "Failed to install packages"; exit 1; }
        else
            echo "### Unsupported OS (FreeBSD with pkg not found)"
            exit 1
        fi
        ;;

    'Darwin')
        echo "### You are using macOS"

        if ! [ -x "$(command -v brew)" ]; then
            # Install Homebrew if it's not already installed
            echo "### Installing Homebrew"
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || { echo "Failed to install Homebrew"; exit 1; }
        fi

        # Additional setup for macOS (asdf)
        echo "### Creating working .config structure for asdf"
        mkdir -p "$HOME/.config/asdf"

        # Source macOS.sh to make it more usable
        echo "### Sourcing macOS.sh script"
        source ./macOS.sh
        ;;

    *)
        echo "### You are using an unsupported OS, $my_os"
        exit 1
        ;;
esac

# The rest of the script remains unchanged
