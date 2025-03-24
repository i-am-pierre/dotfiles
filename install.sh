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

# Get Current directory (the dotfiles repo root)
MY_DOT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Optional: allow selecting a Brewfile variant or skipping it
BREWFILE_OPTION="$1"

case "$BREWFILE_OPTION" in
    --brewfile-small)
        BREWFILE_PATH="$MY_DOT_DIR/Brewfile_small"
        ;;
    --no-brewfile)
        BREWFILE_PATH=""
        ;;
    ""|--brewfile)
        BREWFILE_PATH="$MY_DOT_DIR/Brewfile" # default
        ;;
    *)
        echo "Invalid option: $BREWFILE_OPTION"
        echo "Usage: $0 [--brewfile | --brewfile-small | --no-brewfile]"
        exit 1
        ;;
esac

# Function to install packages
install_packages() {
    local package_manager="$1"
    shift
    echo "### You are using $package_manager"

    if command -v "$package_manager" >/dev/null 2>&1; then
        sudo "$package_manager" update && sudo "$package_manager" install -y "${pkg_list[@]}" || {
            echo "Failed to install packages"
            exit 1
        }
    else
        echo "### $package_manager not found. Please install it."
        exit 1
    fi
}

# Detect platform
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

        if ! command -v brew >/dev/null 2>&1; then
            echo "### Installing Homebrew"
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || {
                echo "Failed to install Homebrew"
                exit 1
            }
        fi

        echo "### Adding brew to PATH temporarily"
        eval "$(/opt/homebrew/bin/brew shellenv)"

        if [ -n "$BREWFILE_PATH" ]; then
            echo "### Installing content of Brewfile: $BREWFILE_PATH"
            brew bundle --file "$BREWFILE_PATH"
        else
            echo "### Skipping brew bundle (per user choice)"
        fi

        echo "### Sourcing macOS.sh script"
        source "$MY_DOT_DIR/scripts/macOS.sh" || {
            echo "Failed to source macOS.sh"
            exit 1
        }

        echo "### Creating .local/share/asdf/completions"
        mkdir -p "$HOME/.local/share/asdf/completions"

        echo "### Generating asdf zsh completions"
        if command -v asdf >/dev/null 2>&1; then
            asdf completion zsh > "$HOME/.local/share/asdf/completions/_asdf"
        fi

        echo "### Creating symlink using Stow for asdf dotfiles"
        if command -v stow >/dev/null 2>&1; then
            stow -vSt "$HOME" asdf || {
                echo "Failed to stow asdf dotfiles"
                exit 1
            }
        else
            echo "Stow not found. Please install it."
        fi
        ;;
    *)
        echo "### You are using an unsupported OS: $my_os"
        exit 1
        ;;
esac

echo "### Creating .config structure"
mkdir -p "$HOME/.config/"{zsh,git,vim}

echo "### Creating symlinks using Stow"
if command -v stow >/dev/null 2>&1; then
    stow -vSt "$HOME" git tmux vim zsh || {
        echo "Failed to stow dotfiles"
        exit 1
    }
else
    echo "Stow not found. Please install it."
fi

if [ "$SHELL" != "$(command -v zsh)" ]; then
    echo "### Changing default shell to Zsh"
    chsh -s "$(command -v zsh)" "$USER" || {
        echo "Failed to update shell to zsh"
        exit 1
    }
else
    echo "### Zsh is already the default shell"
fi

echo "### Installation completed!"
echo "### ➜ Run 'exec zsh -l' or restart your terminal to use Zsh now."
