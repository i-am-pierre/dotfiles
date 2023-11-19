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

2. Run the install.sh script located in the .dotfile folder:

```zsh
./install.sh
```

3. Reload your terminal without killing it:

```zsh
exec zsh -l
```

4. Clean old zsh related files:

```zsh
rm -rf ~/.zsh_sessions && rm ~/.zsh_history
```

5. Rebuild zcompdump for [autocompletion](https://docs.brew.sh/Shell-Completion)

```zsh
rm -f ~/.zcompdump; compinit
```

6. Setup your SSH and PGP Keys following [YubiKey-Guide](https://github.com/drduh/YubiKey-Guide)

7. Setup [asdf](https://asdf-vm.com/guide/getting-started.htm)

8. You can consider updating your git remote repository url to use ssh instead

```zsh
git remote set-url origin_uat git@gitlab.com:i-am-pierre/dotfiles_uat.git
```

FYI Install softwares listed in Brewfile:

```zsh
# Then pass in the Brewfile location...
brew bundle --file ~/.dotfiles/Brewfile

# ...or cleanup to match Brewfile
brew bundle --file ~/.dotfiles/Brewfile --force cleanup

# FYI Creating a detailed Brewfile dump
brew bundle dump --file ~/.dotfiles/Brewfile --describe
```

To be continued...

## GNU/Linux (Debian or Ubuntu, using apt package manager)

0. Install git if git isn't installed and make sure user has sudo priviladges.

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

2. Run the install.sh script located in the .dotfile folder:

```zsh
./install.sh
```

3. Logout and log back into your account

4. You can consider updating your git remote repository url to use ssh instead

```zsh
git remote set-url origin_uat git@gitlab.com:i-am-pierre/dotfiles_uat.git
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

0. Install git if git isn't installed and make sure user has sudo priviladges.

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

2. Run the install.sh script located in the .dotfile folder:

```zsh
bash ./install.sh
```

3. Logout and log back into your account

4. You can consider updating your git remote repository url to use ssh instead

```zsh
git remote set-url origin_uat git@gitlab.com:i-am-pierre/dotfiles_uat.git
```

To be continued...
