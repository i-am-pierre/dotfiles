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

zstyle ':vcs_info:git:*' formats '(%F{red}%b%f)'

setopt PROMPT_SUBST
NEWLINE=$'\n'
PROMPT='[%F{green}%n@%m%f] %F{cyan}%~%f ${vcs_info_msg_0_}$NEWLINE> '

# Configure completions for Homebrew
if [ $(command -v brew) ] ; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  autoload -Uz compinit
  compinit
fi

# Configure completions for asdf and set Path for asdfrc and defaults
if [ $(command -v asdf) ] ; then
  # https://asdf-vm.com/manage/configuration.html#asdfrc
    export ASDF_CONFIG_FILE="$XDG_CONFIG_HOME/asdf/.asdfrc"

    # https://github.com/asdf-vm/asdf-nodejs#default-npm-packages
    export ASDF_NPM_DEFAULT_PACKAGES_FILE="$XDG_CONFIG_HOME/asdf/default-npm-packages"

    # https://github.com/asdf-community/asdf-python#default-python-packages
    export ASDF_PYTHON_DEFAULT_PACKAGES_FILE="$XDG_CONFIG_HOME/asdf/default-python-packages"
  . /opt/homebrew/opt/asdf/libexec/asdf.sh
fi

# Allows your gpg passphrase prompt to spawn (useful for signing commits).
export GPG_TTY="$(tty)"

# Bat Theme
if [ $(command -v bat) ] ; then
  export BAT_THEME="Visual Studio Dark+"
fi

# Load Aliases
if [ -f "$ZDOTDIR/.aliases" ] ; then
  source "$ZDOTDIR/.aliases"
fi
