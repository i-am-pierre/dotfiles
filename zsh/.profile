# ~/.profile (POSIX, runs before zsh)

export ZDOTDIR="$HOME/.config/zsh"

# Ensure ZDOTDIR exists
[ -d "$ZDOTDIR" ] || mkdir -p "$ZDOTDIR"
