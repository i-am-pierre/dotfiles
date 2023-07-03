# History
export HISTFILE=$ZDOTDIR/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILESIZE=20000

# ZSH Options for History
setopt HISTIGNORESPACE # Prevents the current line from being saved if it begins with a space
setopt SHAREHISTORY # Share history across multiple zsh sessions
setopt APPEND_HISTORY #Append to history
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicates first

# ZSH Options
setopt AUTOCD # When you enter the path but forget the leading cd command
setopt RM_STAR_WAIT # Avoid removing everything when rm * is entered

# ZSH Completion
autoload -Uz compinit && compinit

# Prompt
autoload -Uz vcs_info # Enable vcs_info
precmd() { vcs_info } # Always load before displaying the prompt

zstyle ':vcs_info:git:*' formats '(%b) '

setopt PROMPT_SUBST
PROMPT='%n@%m: %F{cyan}%~%f %F{red}${vcs_info_msg_0_}%f'

# Configure completions for Homebrew
if [ $(command -v brew) ] ; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  autoload -Uz compinit
  compinit
fi

# Configure completions for asdf
if [ $(command -v asdf) ] ; then
  . /opt/homebrew/opt/asdf/libexec/asdf.sh
fi

# Allows your gpg passphrase prompt to spawn (useful for signing commits).
export GPG_TTY="$(tty)"

# Load Aliases
if [ -f "$ZDOTDIR/.aliases" ] ; then
  source "$ZDOTDIR/.aliases"
fi
