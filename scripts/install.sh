# !/usr/bin/env sh
# File: install.sh

# Test for the platform and install brew or use pkg or apt to install packages
my_os=$(uname -s)
case $my_os in
    'Linux')
        echo "You are using Linux"
        ;;
    'FreeBSD')
        echo "You are using FreeBSD"
        ;;
    'Darwin')
        echo "You Are using macOS"
        # Source macOS.sh to make it more usable
        echo "Sourcing macOS.sh script"
        source ./macOS.sh
        # Install Brew and add it to PATH temporarily
        echo "Installing Homebrew"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        ;;
    *)
        echo "You are using something else, $my_os"
        ;;
esac
#################


# Create structure
echo "\n Creating working .config structure"
mkdir -p $HOME/.config/{zsh,git,asdf,vim}
#
# Test for content of the .dotfile/ directory to get a list of rep to be created
#
#################



# Use Stow or Ln to make links
#
# TBA
#
#################
echo "\n Install completed"
