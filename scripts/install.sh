#!/usr/bin/env bash
# File: install.sh

# Test for the platform and install brew or use pkg or apt to install packages

my_apt_list=( 
    git 
    vim 
    zsh 
    stow
)

my_os=$(uname -s)

case $my_os in
    'Linux')
        echo -e "### You are usinf Linux \n"
        
        # Installing my_apt_list
        echo -e "### Installing >>>: ${my_apt_list[*]} \n"
        sudo apt update && sudo apt install -y "${my_apt_list[@]}"

    	# Create structure for .config files
	    echo -e "### Creating working .config structure \n"
	    mkdir -p $HOME/.config/{zsh,git,vim}
        ;;
    'FreeBSD')
        echo  "### You are using FreeBSD \n"
	
	    # Create structure
	    echo -e "### Creating working .config structure \n"
	    mkdir -p $HOME/.config/{zsh,git,vim}
	;;
    'Darwin')
        echo -e "### You are using macOS \n"
        
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
echo -e "### Install completed\n"
