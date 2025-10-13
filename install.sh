#!/bin/sh
# File: install.sh

# Define package list
PKG_LIST="bat git pwgen stow tmux vim zsh"

# Get Current directory (the dotfiles repo root)
MY_DOT_DIR=$(cd "$(dirname "$0")" && pwd)

# Optional: allow selecting a Brewfile variant or skipping it
BREWFILE_OPTION=$1

case "$BREWFILE_OPTION" in
    --brewfile-small)
        BREWFILE_PATH="$MY_DOT_DIR/Brewfile_small"
        ;;
    --no-brewfile)
        BREWFILE_PATH=""
        ;;
    ""|--brewfile)
        BREWFILE_PATH="$MY_DOT_DIR/Brewfile"
        ;;
    *)
        echo "Invalid option: $BREWFILE_OPTION"
        echo "Usage: $0 [--brewfile | --brewfile-small | --no-brewfile]"
        exit 1
        ;;
esac

# Function to install packages
install_packages() {
    PACKAGE_MANAGER=$1
    shift
    echo "### You are using $PACKAGE_MANAGER"

    if command -v "$PACKAGE_MANAGER" >/dev/null 2>&1; then
        if [ "$PACKAGE_MANAGER" = "apt" ]; then
            sudo "$PACKAGE_MANAGER" update && sudo "$PACKAGE_MANAGER" install -y $PKG_LIST
        elif [ "$PACKAGE_MANAGER" = "pkg" ]; then
            sudo "$PACKAGE_MANAGER" update -f && sudo "$PACKAGE_MANAGER" install -y $PKG_LIST
        else
            echo "### Unsupported package manager: $PACKAGE_MANAGER"
            exit 1
        fi
    else
        echo "### $PACKAGE_MANAGER not found. Please install it."
        exit 1
    fi
}

# Detect platform
MY_OS=$(uname -s)

case "$MY_OS" in
    Linux)
        install_packages apt
        ;;
    FreeBSD)
        install_packages pkg
        ;;
    Darwin)
        echo "### You are using macOS"

        if ! command -v brew >/dev/null 2>&1; then
            echo "### Installing Homebrew"
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || {
                echo "Failed to install Homebrew"
                exit 1
            }
        fi

        echo "### Adding brew to PATH temporarily"
        eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"

        if [ -n "$BREWFILE_PATH" ]; then
            echo "### Installing content of Brewfile: $BREWFILE_PATH"
            brew bundle --file "$BREWFILE_PATH"
        else
            echo "### Skipping brew bundle (per user choice)"
        fi

        echo "### Running macOS-specific script"
        if [ -f "$MY_DOT_DIR/scripts/macOS.sh" ]; then
            . "$MY_DOT_DIR/scripts/macOS.sh" || {
                echo "Failed to source macOS.sh"
                exit 1
            }
        fi
        ;;
    *)
        echo "### You are using an unsupported OS: $MY_OS"
        exit 1
        ;;
esac

echo "### Creating .config structure"
mkdir -p "$HOME/.config/zsh" "$HOME/.config/git" "$HOME/.config/vim"

echo "### Creating symlinks using Stow"
if command -v stow >/dev/null 2>&1; then
    stow -vSt "$HOME" git tmux vim zsh || {
        echo "Failed to stow dotfiles"
        exit 1
    }
else
    echo "Stow not found. Please install it."
fi

CURRENT_SHELL=$(basename "$SHELL")
ZSH_PATH=$(command -v zsh)

if [ "$CURRENT_SHELL" != "$(basename "$ZSH_PATH")" ]; then
    echo "### Changing default shell to Zsh"
    chsh -s "$ZSH_PATH" "$USER" || {
        echo "Failed to update shell to zsh"
        exit 1
    }
else
    echo "### Zsh is already the default shell"
fi

echo "### Installation completed!"
echo "### ➜ Run 'exec zsh -l' or restart your terminal to use zsh now."
