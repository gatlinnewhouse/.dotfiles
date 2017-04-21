#########################################
#              Zsh Settings             #
#########################################

# Autocorrect commands typed
setopt correctall

# Load advanced prompt settings
autoload -Uz promptinit
promptinit

# Autocomplete with arrow-key interface
zstyle ':completion:*' menu select

# Set zsh to EMACs mode
bindkey -e

# Enable colors
autoload -U colors zsh/terminfo
colors

#########################################
#      Paths, Sources, & Variables      #
#########################################

# Function for adding stuff to path
pathadd() {
  [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]] && PATH="${PATH:+"$PATH:"}$1"
}

# Export environmental variables
export BROWSER="firefox"
export EDITOR="nvim"
export GO_ENV="$HOME/.goenvs"
export GOPATH="$HOME/.go"
export PATH="/usr/local/bin:$PATH"
export SHELL="/bin/zsh"
export SSH_KEY_PATH="~/.ssh/rsa_id"
export TERM="rxvt-unicode"
export ZPLUG_THREADS="24"
export ZPLUG_PROTOCOL="HTTPS"

# Add additional directories to the path.
pathadd $HOME/.local/bin
pathadd $HOME/.scripts

# Source files
source ~/.aliases

# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi

source ~/.zplug/init.zsh

#########################################
#              Z-Plug Plugins           #
#########################################

# Let zplug manage itself
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Requirements for other plugins
zplug "junegunn/fzf-bin", \
  from:gh-r, \
  as:command, \
  rename-to:fzf, \
  use:"*linux*amd64*"

# Completions for zsh plugin
zplug "zsh-users/zsh-completions", as:plugin

# Suggest commands for zsh plugin
zplug "zsh-users/zsh-autosuggestions", as:plugin

# Fish-like syntax highlighting for zsh plugin
zplug "zsh-users/zsh-syntax-highlighting", as:plugin

# Forked, independent oh-my-zsh colored-man-pages plugin
zplug "zuxfoucault/colored-man-pages_mod", as:plugin

# Command not found package suggestor plugin
zplug "Tarrasch/zsh-command-not-found", as:plugin

# Libnotify for zsh plugin
zplug "marzocchi/zsh-notify", as:plugin

# Emoji menu plugin
zplug "stedolan/jq", \
    from:gh-r, \
    as:command, \
    rename-to:jq
zplug "b4b4r07/emoji-cli", \
    on:"stedolan/jq"

# Per directory history plugin
zplug "tymm/zsh-directory-history", as:plugin

# Human readable errors plugin
zplug "aphelionz/strerror.plugin.zsh", as:plugin

# Emoji/Emoticon plugin
zplug "MichaelAquilina/zsh-emojis", as:plugin

# Zsh calculator
zplug "arzzen/calc.plugin.zsh", as:plugin

# goenv path variable
zplug "bbenne10/goenv", as:plugin

# Human readable time plugin
zplug "sindresorhus/pretty-time-zsh", as:plugin

# ls with git support
zplug "supercrabtree/k", as:plugin

# Import oh-my-zsh plugins
zplug "robbyrussell/oh-my-zsh", use:"lib/git.zsh", defer:1, as:plugin
zplug "robbyrussell/oh-my-zsh", use:"lib/prompt_info_functions.zsh", defer:1, as:plugin
zplug "robbyrussell/oh-my-zsh", use:"lib/nvm.zsh", defer:1, as:plugin
zplug "robbyrussell/oh-my-zsh", use:"lib/bzr.zsh", defer:1, as:plugin
zplug "plugins/git", from:oh-my-zsh, as:plugin, defer:1
zplug "plugins/gpg-agent", from:oh-my-zsh, as:plugin, defer:1
zplug "plugins/ssh-agent", from:oh-my-zsh, as:plugin, defer:1
zplug "~/.zsh", from:local, use:"papercolor.zsh-theme", as:theme, defer:2

# zplug check returns true if all packages are installed
# Therefore, when it returns false, run zplug install
if ! zplug check; then
    zplug install
fi

# source plugins and add commands to the PATH
zplug load
