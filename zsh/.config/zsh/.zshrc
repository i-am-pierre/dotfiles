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
# Zsh Completion Initialization
# ------------------------------------------------------------------------------
autoload -Uz compinit

# Rebuild completion dump if needed
if [[ ! -f "${XDG_CACHE_HOME}/zsh/zcompdump" ]]; then
  mkdir -p "${XDG_CACHE_HOME}/zsh"
  compinit -d "${XDG_CACHE_HOME}/zsh/zcompdump"
else
  compinit -d "${XDG_CACHE_HOME}/zsh/zcompdump"
fi

# ------------------------------------------------------------------------------
#  Enable shell autocompletion for uv and uvx commands
# ------------------------------------------------------------------------------
if command -v uv &>/dev/null; then
  eval "$(uv --generate-shell-completion zsh)"
  eval "$(uvx --generate-shell-completion zsh)"
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
