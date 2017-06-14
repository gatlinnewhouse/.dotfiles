#########################################
#              Zsh Settings             #
#########################################

# Autocorrect commands typed
#setopt correctall

# if you do a 'rm *', Zsh will give you a sanity check!
setopt RM_STAR_WAIT

# Autocomplete with arrow-key interface
# and persistent rehashing for updating and adding new items to $PATH
zstyle ':completion:*' menu select rehash true

# Set zsh to EMACs mode
bindkey -e

# Set Home key to begging of line
# and End key to end of line
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line

# Load modules:
autoload -Uz compinit promptinit
# Command completion
compinit
# Load fancy prompt
promptinit

# Enable colors
autoload -U colors zsh/terminfo
colors

# Load history
#autoload -Uz add-zsh-hook
#add-zsh-hook preexec _start_timer
#add-zsh-hook precmd  _stop_timer

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
export _JAVA_OPTIONS='-Dsun.java2d.opengl=true -Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
export LESS='-R '
export PATH="/usr/local/bin:$PATH"
export QT_QPA_PLATFORMTHEME="gtk2"
export SHELL="/bin/zsh"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export SSH_KEY_PATH="~/.ssh/rsa_id"
export TERM="xterm-xfree86"
export ZPLUG_THREADS="24"
export ZPLUG_PROTOCOL="HTTPS"

# LS colors, made with http://geoff.greer.fm/lscolors/
# export LSCOLORS="exfxcxdxbxegedabagacad"
export LS_COLORS='di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'
export GREP_COLOR='1;33'

# Enable LS_COLORS in tab completion
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Enable arrow key driven autocompletion
zstyle ':completion:*' menu select

# Add additional directories to the path.
pathadd $HOME/.local/bin
pathadd $HOME/.gem/ruby/2.4.0/bin
pathadd $HOME/.scripts/

# Source files
source ~/.aliases

# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
else
  source ~/.zplug/init.zsh
fi

#########################################
#              Z-Plug Plugins           #
#########################################

# Let zplug manage itself
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Requirements for other plugins
# Adds a fuzzy search
zplug "junegunn/fzf-bin", \
  from:gh-r, \
  as:command, \
  rename-to:fzf, \
  use:"*linux*amd64*"

# Completions for zsh
zplug "zsh-users/zsh-completions", as:plugin

# Fish-like syntax highlighting for zsh
zplug "zdharma/fast-syntax-highlighting", as:plugin

# Forked, independent oh-my-zsh colored-man-pages
zplug "zuxfoucault/colored-man-pages_mod", as:plugin

# Emoji menu plugin dependency - don't use if Emoji CLI is broken
#zplug "stedolan/jq", \
#  from:gh-r, \
#  as:command, \
#  rename-to:jq

# Emoji CLI - not working?
#zplug "b4b4r07/emoji-cli", as:plugin

# Human readable time
zplug "sindresorhus/pretty-time-zsh", as:plugin

# Human readable errors
zplug "aphelionz/strerror.plugin.zsh", as:plugin

# Emoji/Emoticon
zplug "MichaelAquilina/zsh-emojis", as:plugin

# Hacker quotes - not working?
#zplug "oldratlee/hacker-quotes", as:plugin

# Git extra commands (to make things easier)
zplug "unixorn/git-extra-commands", as:plugin, use:"git-extra-commands.plugin.zsh"

# 256 ZSH Color
zplug "chrissicool/zsh-256color", as:plugin

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
