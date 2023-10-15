#!/usr/bin/bash
# File: install.sh

my_apt_list=( 
    git 
    stow
    vim 
    zsh 
)

my_os=$(uname -s)

# Test for the platform and install brew or use pkg or apt to install packages
case $my_os in
    'Linux')
        echo -e "### You are usinf Linux \n"
        
        # Installing my_apt_list
        echo -e "### Installing >>>: ${my_apt_list[*]} \n"
        sudo apt update && sudo apt install -y "${my_apt_list[@]}"

    	# Create structure for .config files
	    echo -e "### Creating working .config structure \n"
	    mkdir -p "$HOME"/.config/{zsh,git,vim}

        # Stow .dotfiles
        echo -e "### Creating simlink using Stow"
        cd ~/.dotfiles
        stow -vSt ~ git tmux vim zsh

        # Updating shell to zsh for user
        echo -e "### Updating shell to zsh"
        chsh -s /bin/zsh $USER
        ;;

    'FreeBSD')
        echo -e "### You are using FreeBSD \n"
	
	    # Create structure
	    echo -e "### Creating working .config structure \n"
	    mkdir -p "$HOME"/.config/{zsh,git,vim}
	;;

    'Darwin')
        echo -e "### You are using macOS \n"
        
	    # Create structure
	    echo -e "### Creating working .config structure \n"
	    mkdir -p "$HOME"/.config/{zsh,git,vim,asdf}
        
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
echo -e "### Install completed"
echo -e "### Consider exec zsh -l to laod zsh now\n"

