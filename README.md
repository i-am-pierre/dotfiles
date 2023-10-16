# Steps to bootstrap a new system

The goal of all of this is to quickly install dotfiles and apps on mulitple platforms.

## macOS

0. Install Apple's Command Line Tool (if needed)

```zsh
xcode-select --install
```

1. Clone dotfiles repository into ~/.dotfiles:

```zsh
git clone https://github.com/i-am-pierre/dotfiles.git ~/.dotfiles
```

UAT reporsitory:

```zsh
git clone https://gitlab.com/i-am-pierre/dotfiles_uat.git ~/.dotfiles
```

2. Run the install.sh script located in the .dotfile/scripts/ folder:

```zsh
# move into your .dotfiles/ directory:
cd .dotfile/scripts/

# Use the install script
./install.sh
```

```zsh
# Add brew to PATH temporarily
eval "$(/opt/homebrew/bin/brew shellenv)"
```

3. Install softwares listed in the Brewfile:

```zsh
# Then pass in the Brewfile location...
brew bundle --file ~/.dotfiles/Brewfile

# ...or cleanup to match Brewfile
brew bundle --file ~/.dotfiles/Brewfile --force cleanup

# FYI Creating a detailed Brewfile dump
brew bundle dump --file ~/.dotfiles/Brewfile --describe
```

4. Create symlinks in the Home directory to the real files in the repo using [GNU Stow](https://www.gnu.org/software/stow/)

```zsh
# move into your .dotfiles/ directory:
cd .dotfiles

# Test your stow command first to stow your 'zsh', 'git' and 'asdf' folders:
stow -nvSt ~ asdf git tmux vim zsh

# If everything looks good, do it for real:
stow -vSt ~ asdf git tmux vim zsh
```

5. Reload your terminal without killing it:

```zsh
exec zsh -l
```

6. Clean old zsh related files:

```zsh
rm -rf ~/.zsh_sessions && rm ~/.zsh_history
```

7. Rebuild zcompdump for [autocompletion](https://docs.brew.sh/Shell-Completion)

```zsh
rm -f ~/.zcompdump; compinit
```

8. Setup your SSH and PGP Keys following [YubiKey-Guide](https://github.com/drduh/YubiKey-Guide)

9. Setup [asdf](https://asdf-vm.com/guide/getting-started.htm)

10. You can consider updating your git remote repository url to use ssh instead

```zsh
git remote --set-url origin git@gitlab.com:i-am-pierre/dotfiles_uat.git
```

To be continued...

## Linux (Debian and Ubuntu, using apt package manager)

0. Install git if git isn't installed ans make sure user has sudo priviladges.

```zsh
sudo apt update && sudo apt install -y git
```

1. Clone dotfiles repository into ~/.dotfiles:

```zsh
git clone https://github.com/i-am-pierre/dotfiles.git ~/.dotfiles
```

UAT reporsitory:

```zsh
git clone https://gitlab.com/i-am-pierre/dotfiles_uat.git ~/.dotfiles
```

2. Run the install.sh script located in the .dotfile/scripts/ folder:

```zsh
# move into your .dotfiles/ directory:
cd .dotfile/scripts/

# Use the install script
./install.sh
```

3. Logout and log back into your account

4. You can consider updating your git remote repository url to use ssh instead

```zsh
git remote --set-url origin git@gitlab.com:i-am-pierre/dotfiles_uat.git
```

To be continued...

## FreeBSD

***Note :*** This only works if the user has sudo privildges and bash installed for now

```zsh
# add user pierre to wheel
pw groupmod wheel -m pierre
# use visudo to update sudoers
visudo
#uncomment the following to allow members of wheel to execute any command
%wheel ALL=(All:ALL) All
```

0. Install git if git isn't installed ans make sure user has sudo priviladges.

```zsh
sudo pkg update && sudo pkg install -y git bash
```

1. Clone dotfiles repository into ~/.dotfiles:

```zsh
git clone https://github.com/i-am-pierre/dotfiles.git ~/.dotfiles
```

UAT reporsitory:

```zsh
git clone https://gitlab.com/i-am-pierre/dotfiles_uat.git ~/.dotfiles
```

2. Run the install.sh script located in the .dotfile/scripts/ folder:

```zsh
# move into your .dotfiles/ directory:
cd .dotfile/scripts/

# Use the install script
bash ./install.sh
```

3. Logout and log back into your account

4. You can consider updating your git remote repository url to use ssh instead

```zsh
git remote --set-url origin git@gitlab.com:i-am-pierre/dotfiles_uat.git
```

To be continued...
