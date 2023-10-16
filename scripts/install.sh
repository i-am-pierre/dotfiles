#!/bin/bash
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

# Test for the platform and install packages accordingly
case $my_os in
    'Linux')
        if [ -x "$(command -v apt)" ]; then
            # Debian-based Linux (e.g., Ubuntu)
            echo -e "### You are using Debian-based Linux \n"
            sudo apt update && sudo apt install -y "${my_pkg_list[@]}"
        else
            echo -e "### Unsupported Linux distribution \n"
            exit 1
        fi

    	# Create structure for .config files
	    echo -e "### Creating working .config structure \n"
	    mkdir -p "$HOME"/.config/{zsh,git,vim}

        # Stow .dotfiles
        echo -e "### Creating simlink using Stow"
        cd ~/.dotfiles || exit 1
        stow -vSt ~ git tmux vim zsh

        # Updating shell to zsh for user
        echo -e "### Updating shell to zsh"
        chsh -s /bin/zsh "$USER"
        ;;

      'FreeBSD')
        if [ -x "$(command -v pkg)" ]; then
            echo -e "### You are using FreeBSD \n"
            sudo pkg update && sudo pkg install -y "${my_pkg_list[@]}"
        else
            echo -e "### Unsupported OS (FreeBSD with pkg not found) \n"
            exit 1
        fi
       
    	# Create structure for .config files
	    echo -e "### Creating working .config structure \n"
	    mkdir -p "$HOME"/.config/{zsh,git,vim}

        # Stow .dotfiles
        echo -e "### Creating simlink using Stow"
        cd ~/.dotfiles || exit 1
        stow -vSt ~ git tmux vim zsh

        # Updating shell to zsh for user
        echo -e "### Updating shell to zsh"
        chsh -s /usr/local/bin/zsh "$USER"
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
        echo -e "### You are using an unsupported OS, $my_os \n"
        ;;
esac

echo -e "### Install completed"
echo -e "### Consider exec zsh -l to load zsh now\n or logout"
