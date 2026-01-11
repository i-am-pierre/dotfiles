# ==============================================================================
# Zsh Environment File (.zshenv)
#
# Loaded for ALL zsh invocations:
# - interactive shells
# - non-interactive shells
# - scripts
# - cron / scp / automation
#
# Keep this file MINIMAL and SIDE-EFFECT FREE.
# ==============================================================================


# ==============================================================================
# XDG Base Directory Specification
# ==============================================================================

# User-specific configuration files
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

# User-specific data files
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

# User-specific non-essential cached data
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# ZSH base directories
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"



# ==============================================================================
# Editor
# ==============================================================================

# Default editor used by CLI tools (git, crontab, visudo, etc.)
# Keep this lightweight and universally available
export EDITOR="${EDITOR:-nano}"
