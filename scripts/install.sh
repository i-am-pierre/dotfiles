# !/usr/bin/env sh
# File: install.sh

# Test for the platform and install brew or use pkg or apt to install packages

my_os=$(uname -s)

case $my_os in
    'Linux')
        echo  "### You are using Linux \n"
	
    	# Create structure
	    echo  "### Creating working .config structure \n"
	    mkdir -p $HOME/.config/{zsh,git,vim}
        sudo apt update && sudo apt install 
        ;;
    'FreeBSD')
        echo  "### You are using FreeBSD \n"
	
	    # Create structure
	    echo  "### Creating working .config structure \n"
	    mkdir -p $HOME/.config/{zsh,git,vim}
	;;
    'Darwin')
        echo  "### You Are using macOS \n"
        
	    # Create structure
	    echo  "### Creating working .config structure \n"
	    mkdir -p $HOME/.config/{zsh,git,vim,asdf}
        
        # Source macOS.sh to make it more usable
        echo  "### Sourcing macOS.sh script \n"
        source ./macOS.sh
        # Install Brew and add it to PATH temporarily
        echo  "### Installing Homebrew \n"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        ;;
    *)
        echo  "### You are using something else, $my_os \n"
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
echo "Install completed\n"
