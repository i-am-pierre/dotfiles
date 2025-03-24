# ------------------------------------------------------------------------------
# History Settings
# ------------------------------------------------------------------------------
export HISTFILE="$ZDOTDIR/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILESIZE=20000

setopt HISTIGNORESPACE SHAREHISTORY APPEND_HISTORY HIST_EXPIRE_DUPS_FIRST

# ------------------------------------------------------------------------------
# Zsh Options
# ------------------------------------------------------------------------------
setopt AUTOCD        # Allow `cd dir` to be just `dir`
setopt RM_STAR_WAIT  # Confirm before `rm *`

# ------------------------------------------------------------------------------
# Prompt + Git Info
# ------------------------------------------------------------------------------
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '(%F{red}%b%f)'
setopt PROMPT_SUBST

NEWLINE=$'\n'
PROMPT='[%F{green}%n@%m%f] %F{cyan}%~%f ${vcs_info_msg_0_}$NEWLINE> '

# ------------------------------------------------------------------------------
# asdf (installed via Homebrew, completions generated manually)
# ------------------------------------------------------------------------------
export ASDF_DATA_DIR="$XDG_DATA_HOME/asdf"
export PATH="$ASDF_DATA_DIR/shims:$PATH"

# Optional default packages for plugins
export ASDF_NPM_DEFAULT_PACKAGES_FILE="$XDG_CONFIG_HOME/asdf/default-npm-packages"
export ASDF_PYTHON_DEFAULT_PACKAGES_FILE="$XDG_CONFIG_HOME/asdf/default-python-packages"

# Add manually generated asdf completions to fpath
fpath=("$ASDF_DATA_DIR/completions" $fpath)

# ------------------------------------------------------------------------------
# Zsh Completion Initialization
# ------------------------------------------------------------------------------
autoload -Uz compinit
compinit

# Link asdf completions
if type _asdf &>/dev/null; then
  compdef _asdf asdf
fi

# ------------------------------------------------------------------------------
# GPG TTY Setup
# ------------------------------------------------------------------------------
export GPG_TTY="$(tty)"

# ------------------------------------------------------------------------------
# bat Theme (Visual Studio Dark+)
# ------------------------------------------------------------------------------
if command -v bat &>/dev/null; then
  export BAT_THEME="Visual Studio Dark+"
fi

# ------------------------------------------------------------------------------
# Load Aliases (if available)
# ------------------------------------------------------------------------------
if [ -f "$ZDOTDIR/.aliases" ]; then
  source "$ZDOTDIR/.aliases"
fi
