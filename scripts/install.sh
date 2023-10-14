# !/usr/bin/env sh
# File: install.sh

# Test for the platform and install brew or use pkg or apt to install packages

my_os=$(uname -s)

set -x

case $my_os in
    'Linux')
        echo -e "### You are using Linux \n"
	
	# Create structure
	echo -e "### Creating working .config structure \n"
	mkdir -p $HOME/.config/{zsh,git,vim}
        ;;
    'FreeBSD')
        echo -e "### You are using FreeBSD \n"
	
	# Create structure
	echo -e "### Creating working .config structure \n"
	mkdir -p $HOME/.config/{zsh,git,vim}
	;;
    'Darwin')
        echo -e "### You Are using macOS \n"
        
	# Create structure
	echo -e "### Creating working .config structure \n"
	mkdir -p $HOME/.config/{zsh,git,vim,asdf}
        
        # Source macOS.sh to make it more usable
        echo -e "### Sourcing macOS.sh script \n"
        source ./macOS.sh
        # Install Brew and add it to PATH temporarily
        echo -e "### Installing Homebrew \n"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        ;;
    *)
        echo -e "### You are using something else, $my_os \n"
        ;;
esac
#################


#
# Test for content of the .dotfile/ directory to get a list of rep to be created
#
#################



# Use Stow or Ln to make links
#
# TBA
#
#################
echo -e  "Install completed\n"
