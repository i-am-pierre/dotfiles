## Steps to bootstrap a new Mac

0. Install Apple's Command Line Tool (if needed)

```zsh
xcode-select --install
```


1. Clone your dotfiles repo into new hidden directory:
```zsh
git clone https://github.com/i-am-pierre/dotfiles.git ~/.dotfiles
```

UAT version
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


3. Install the software listed in the Brewfile:
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


8. Set your SSH and PGP Keys following [YubiKey-Guide](https://github.com/drduh/YubiKey-Guide)


9. Setup [asdf](https://asdf-vm.com/guide/getting-started.htm)


To be continued...
