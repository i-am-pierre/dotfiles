# Steps to bootstrap a new system

This repository sets up a consistent developer environment across platforms using `stow`, `zsh`, `asdf`, and XDG standards.

## macOS Setup

### 0. Install Apple Command Line Tools (if not already installed)

```zsh
xcode-select --install
```

### 1. Clone the dotfiles repository

```zsh
git clone https://github.com/i-am-pierre/dotfiles.git ~/.dotfiles
```

### 2. Run the installer

```zsh
cd ~/.dotfiles
./install.sh
```

### 3. Reload Zsh without restarting the terminal

```zsh
exec zsh -l
```

### 4. (Optional) Clean legacy Zsh files (if any)

```zsh
rm -rf ~/.zsh_sessions ~/.zsh_history
```

### 5. (Optional) Rebuild Zsh completion cache (if any)

```zsh
rm -f ~/.zcompdump
compinit
```

Note: You only need this if completions misbehave. The install script already sets up completions properly.

### 6. Set up SSH and GPG keys

Follow the YubiKey guide:  
https://github.com/drduh/YubiKey-Guide

### 7. Use asdf to manage pluggins (Python etc..)

https://asdf-vm.com/guide/getting-started.html

### 8. (Optional) Switch Git remote to SSH

```zsh
git remote set-url origin git@github.com/i-am-pierre/dotfiles.git ~/.dotfiles
```

## Homebrew Tips

Install or update software via Brewfile:

```zsh
brew bundle --file ~/.dotfiles/Brewfile
```

To clean up extras not in the Brewfile:

```zsh
brew bundle --file ~/.dotfiles/Brewfile --force cleanup
```

To generate a new Brewfile with comments:

```zsh
brew bundle dump --file ~/.dotfiles/Brewfile --describe --force
```

---

## GNU/Linux (Debian or Ubuntu)

### 0. Install Git if needed

```zsh
sudo apt update && sudo apt install -y git
```

### 1. Clone and install

```zsh
git clone https://github.com/i-am-pierre/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

### 2. Log out and back in

This applies your shell and Stow changes.

### 3. (Optional) Switch Git remote to SSH

```zsh
git remote set-url origin git@github.com/i-am-pierre/dotfiles.git ~/.dotfiles
```

---

## FreeBSD

Note: This requires `bash` and `sudo`, and the user must be in the `wheel` group.

### 0. Add your user to the wheel group and configure sudo

```zsh
sudo pw groupmod wheel -m pierre
sudo visudo
```

Uncomment the following line to allow members of the wheel group to use sudo:

```
%wheel ALL=(ALL:ALL) ALL
```

### 1. Install Git and Bash

```zsh
sudo pkg update && sudo pkg install -y git bash
```

### 2. Clone and install

```zsh
git clone https://github.com/i-am-pierre/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
bash ./install.sh
```

### 3. Log out and back in

This applies shell and dotfile changes.

### 4. (Optional) Switch Git remote to SSH

```zsh
git remote set-url origin git@github.com/i-am-pierre/dotfiles.git ~/.dotfiles
```

---

## Notes

- The `install.sh` script uses `stow` to symlink config files from the repo.
- On macOS, it generates proper `asdf` completions and sets up `zsh`.
- Compatible with XDG directories.
- You can re-run the script anytime to reapply settings or stow updates.

To restart your shell manually:

```zsh
exec zsh -l
```

To be continued...
