# ==============================================================================
# Zsh Login Shell Configuration (.zprofile)
#
# Purpose:
# - Login-time environment setup
# - PATH / MANPATH initialization
# - Platform-specific tooling (Homebrew, uv)
#
# This file runs ONLY for login shells.
# ==============================================================================

# ==============================================================================
# Ensure Zsh Runtime Directories Exist
# ==============================================================================

# Safe to create directories here (login shell only)
mkdir -p "$ZDOTDIR" \
         "$XDG_CACHE_HOME/zsh"

# ==============================================================================
# Homebrew Environment (macOS only)
# ==============================================================================

# Use OSTYPE instead of calling uname (faster, no subshell)
if [[ "$OSTYPE" == darwin* ]]; then
  # Apple Silicon Homebrew (preferred)
  if [[ -x /opt/homebrew/bin/brew ]]; then
    # brew shellenv sets PATH, MANPATH, INFOPATH correctly
    eval "$(/opt/homebrew/bin/brew shellenv)"

  # Intel Homebrew fallback
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi


# ==============================================================================
# uv Tooling (Python / ML utilities)
# ==============================================================================

# uv installs tools under ~/.local/share/uv/tools/*
# Add the tools directory to PATH only if it exists
UV_TOOLS_DIR="$HOME/.local/share/uv/tools"

if [[ -d "$UV_TOOLS_DIR" ]]; then
  # Prepend to PATH so uv-managed tools take precedence
  path=("$UV_TOOLS_DIR"/*/bin $path)
fi


# ==============================================================================
# PATH Hygiene
# ==============================================================================

# Deduplicate PATH entries AFTER all modifications
# Zsh treats PATH as the array "path"
typeset -U path
