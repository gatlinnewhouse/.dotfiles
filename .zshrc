#########################################
#              Zsh Settings             #
#########################################

# Autocorrect commands typed
setopt correctall

# if you do a 'rm *', Zsh will give you a sanity check!
setopt RM_STAR_WAIT

# Autocomplete with arrow-key interface
zstyle ':completion:*' menu select

# Set zsh to EMACs mode
bindkey -e

# Set Home key to begging of line
# and End key to end of line
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line

# Enable colors
autoload -U colors zsh/terminfo
[[ -s "$HOME/.zplug/repos/garabik/grc/grc.zsh" ]] && source $HOME/.zplug/repos/garabik/grc/grc.zsh
colors

# Load history
autoload -Uz add-zsh-hook
add-zsh-hook preexec _start_timer
add-zsh-hook precmd  _stop_timer

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
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export SSH_KEY_PATH="~/.ssh/rsa_id"
export TERM="xterm-xfree86"
export ZPLUG_THREADS="24"
export ZPLUG_PROTOCOL="HTTPS"

# LS colors, made with http://geoff.greer.fm/lscolors/
export LSCOLORS="exfxcxdxbxegedabagacad"
export LS_COLORS='di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'
export LS_OPTIONS=(--color=auto -a -q)
export GREP_COLOR='1;33'

# Enable LS_COLORS
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Add additional directories to the path.
pathadd $HOME/.local/bin
pathadd $HOME/.scripts

# Source files
source ~/.aliases

# History substring search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi

# Load zplug
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
zplug "zdharma/fast-syntax-highlighting", as:plugin

# Forked, independent oh-my-zsh colored-man-pages plugin
zplug "zuxfoucault/colored-man-pages_mod", as:plugin

# Emoji menu plugin dependency
zplug "stedolan/jq", \
  from:gh-r, \
  as:command, \
  rename-to:jq

# Emoji CLI
zplug "b4b4r07/emoji-cli", as:plugin

# Human readable time
zplug "sindresorhus/pretty-time-zsh", as:plugin

# Human readable errors plugin
zplug "aphelionz/strerror.plugin.zsh", as:plugin

# Emoji/Emoticon plugin
zplug "MichaelAquilina/zsh-emojis", as:plugin

# Hacker quotes
zplug "oldratlee/hacker-quotes", as:plugin

# ls with git support
zplug "supercrabtree/k", as:plugin

# 256 ZSH Color Plugin
zplug "chrissicool/zsh-256color", as:plugin

# Color support
zplug "garabik/grc", as:plugin

# zsh history substring search
zplug "zsh-users/zsh-history-substring-search", as:plugin

# ZSH history MySQL database
zplug "larkery/zsh-histdb", use:"history-timer.zsh", as:plugin
zplug "larkery/zsh-histdb", use:"sqlite-history.zsh", as:plugin

# Import oh-my-zsh plugins
zplug "$HOME/.zplug/repos/robbyrussell/oh-my-zsh", from:local, use:"lib/git.zsh", defer:2, as:plugin
zplug "$HOME/.zplug/repos/robbyrussell/oh-my-zsh", from:local, use:"lib/prompt_info_functions.zsh", defer:1, as:plugin
zplug "$HOME/.zsh", from:local, use:"papercolor.zsh-theme", as:theme, defer:3

# zplug check returns true if all packages are installed
# Therefore, when it returns false, run zplug install
if ! zplug check; then
  zplug install
fi

# source plugins and add commands to the PATH
zplug load

# Use zsh-autosuggestions with zsh mysql history
_zsh_autosuggest_strategy_histdb_top_here() {
  local query="select commands.argv from history left join commands on history.command_id = commands.rowid left join places on history.place_id = places.rowid where places.dir LIKE '$(sql_escape $PWD)%' and commands.argv LIKE '$(sql_escape $1)%' group by commands.argv order by  count(*) desc limit 1" 
  _histdb_query "$query"
}

ZSH_AUTOSUGGEST_STRATEGY=histdb_top_here
