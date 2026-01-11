# ==============================================================================
# History Configuration
# ==============================================================================

# Location of the history file
# Using ZDOTDIR keeps shell state out of $HOME root
export HISTFILE="$ZDOTDIR/.zsh_history"

# Number of commands kept in memory during a session
export HISTSIZE=10000

# Number of commands saved to disk when the shell exits
export SAVEHIST=10000

# Maximum size of the history file on disk
export HISTFILESIZE=20000

# Do not record commands starting with a space (useful for secrets)
setopt HISTIGNORESPACE

# Share history between all running zsh sessions
setopt SHAREHISTORY

# Append to the history file instead of overwriting it
setopt APPEND_HISTORY

# Write history entries immediately, not just on shell exit
# Essential when using multiple terminals
setopt INC_APPEND_HISTORY

# When trimming history, expire duplicate entries first
setopt HIST_EXPIRE_DUPS_FIRST

# Do not show duplicate results during history search (Ctrl-R)
setopt HIST_FIND_NO_DUPS

# Remove unnecessary blanks from history entries
setopt HIST_REDUCE_BLANKS


# ==============================================================================
# Core Shell Behavior
# ==============================================================================

# Allow changing directories by typing the directory name only
# Example: `Documents` instead of `cd Documents`
setopt AUTOCD

# Require confirmation before running dangerous glob deletes like `rm *`
setopt RM_STAR_WAIT


# ==============================================================================
# Prompt and Version Control (Git) Information
# ==============================================================================

# Load Zsh helper for managing multiple precmd hooks safely
autoload -Uz add-zsh-hook

# Load vcs_info for lightweight VCS (Git) prompt integration
autoload -Uz vcs_info

# Configure Git branch display format
# %b = branch name
# %F{red} = red foreground color
zstyle ':vcs_info:git:*' formats '(%F{red}%b%f)'

# Register vcs_info to run before each prompt display
add-zsh-hook precmd vcs_info

# Allow parameter expansion inside PROMPT
setopt PROMPT_SUBST

# Prompt layout:
# [user@host] current_path (git_branch)
# >
PROMPT='[%F{green}%n@%m%f] %F{cyan}%~%f ${vcs_info_msg_0_}
> '


# ==============================================================================
# Command Line Editing Enhancements
# ==============================================================================

# Load the widget that opens the current command in $EDITOR
autoload -Uz edit-command-line

# Register the widget with ZLE (Zsh Line Editor)
zle -N edit-command-line

# Bind Ctrl+X Ctrl+E to open the current command in $EDITOR
# Extremely useful for long or complex commands
bindkey '^X^E' edit-command-line

# Enable "magic space":
# Expands history references like !!, !$ when pressing space
bindkey ' ' magic-space


# ==============================================================================
# Completion System (XDG-compliant)
# ==============================================================================

# Add a custom completions directory before the default ones
# Useful for manually installed or project-specific completions
fpath=(
  "$ZDOTDIR/completions"
  $fpath
)

# Load Zsh completion system
autoload -Uz compinit

# Define completion dump location following XDG spec
# Falls back safely if XDG_CACHE_HOME is not set
ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"

# Ensure the parent directory exists
mkdir -p "${ZSH_COMPDUMP:h}"

# Initialize completions using the specified dump file
# This speeds up shell startup after the first run
compinit -d "$ZSH_COMPDUMP"


# ==============================================================================
# uv / uvx Shell Completions (Python Tooling)
# ==============================================================================

# Enable dynamic shell completions for uv and uvx
# Only runs if both commands are available
if command -v uv &>/dev/null && command -v uvx &>/dev/null; then
  eval "$(uv --generate-shell-completion zsh)"
  eval "$(uvx --generate-shell-completion zsh)"
fi


# ==============================================================================
# GPG / age / sops Compatibility
# ==============================================================================

# Export the current TTY for GPG
# Required for correct pinentry behavior in terminal sessions
export GPG_TTY="$(tty)"


# ==============================================================================
# Tool-Specific Environment Variables
# ==============================================================================

# Configure bat (cat replacement) theme if installed
# Visual Studio Dark+ matches most modern editors
if command -v bat &>/dev/null; then
  export BAT_THEME="Visual Studio Dark+"
fi


# ==============================================================================
# Aliases
# ==============================================================================

# Load aliases from a separate file if present
# Keeps this file clean and focused
[[ -f "$ZDOTDIR/.aliases" ]] && source "$ZDOTDIR/.aliases"
