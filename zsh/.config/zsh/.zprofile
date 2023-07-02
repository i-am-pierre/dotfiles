# Set PATH, MANPATH, etc., for Homebrew.
if [[ $(uname) == Darwin ]] ; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
