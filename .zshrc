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

# Setup keybindings
autoload zkbd
function zkbd_file() {
    [[ -f ~/.zkbd/${TERM}-${VENDOR}-${OSTYPE} ]] && printf '%s' ~/".zkbd/${TERM}-${VENDOR}-${OSTYPE}" && return 0
    [[ -f ~/.zkbd/${TERM}-${DISPLAY}          ]] && printf '%s' ~/".zkbd/${TERM}-${DISPLAY}"          && return 0
    return 1
}

[[ ! -d ~/.zkbd ]] && mkdir ~/.zkbd
keyfile=$(zkbd_file)
ret=$?
if [[ ${ret} -ne 0 ]]; then
    zkbd
    keyfile=$(zkbd_file)
    ret=$?
fi
if [[ ${ret} -eq 0 ]] ; then
    source "${keyfile}"
else
    printf 'Failed to setup keys using zkbd.\n'
fi
unfunction zkbd_file; unset keyfile ret

# setup key accordingly
[[ -n "$key[Home]"      ]] && bindkey -- "$key[Home]"      beginning-of-line
[[ -n "$key[End]"       ]] && bindkey -- "$key[End]"       end-of-line
[[ -n "$key[Insert]"    ]] && bindkey -- "$key[Insert]"    overwrite-mode
[[ -n "$key[Backspace]" ]] && bindkey -- "$key[Backspace]" backward-delete-char
[[ -n "$key[Delete]"    ]] && bindkey -- "$key[Delete]"    delete-char
[[ -n "$key[Up]"        ]] && bindkey -- "$key[Up]"        up-line-or-history
[[ -n "$key[Down]"      ]] && bindkey -- "$key[Down]"      down-line-or-history
[[ -n "$key[Left]"      ]] && bindkey -- "$key[Left]"      backward-char
[[ -n "$key[Right]"     ]] && bindkey -- "$key[Right]"     forward-char

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
export _JAVA_OPTIONS='-Dsun.java2d.opengl=true -Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
export LESS='-R '
export LOGNAME="godel"
export PATH="/usr/local/bin:$PATH"
export QT_QPA_PLATFORMTHEME="gtk2"
export SHELL="/bin/zsh"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export SSH_CONNECTION="rhizome"
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
pathadd $HOME/.scripts/submodules/emojify/emojify

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

# Completions for zsh
zplug "zsh-users/zsh-completions", as:plugin

# Fish-like syntax highlighting for zsh
zplug "zdharma/fast-syntax-highlighting", as:plugin

# Forked, independent oh-my-zsh colored-man-pages
zplug "zuxfoucault/colored-man-pages_mod", as:plugin

# Human readable time
zplug "sindresorhus/pretty-time-zsh", as:plugin

# Human readable errors
zplug "aphelionz/strerror.plugin.zsh", as:plugin

# Hacker quotes - not working?
zplug "oldratlee/hacker-quotes", as:plugin

# Git extra commands (to make things easier)
zplug "unixorn/git-extra-commands", as:plugin, use:"git-extra-commands.plugin.zsh"

# 256 ZSH Color
zplug "chrissicool/zsh-256color", as:plugin

# Zsh emoji completion
zplug "b4b4r07/emoji-cli"

# ZSH history MySQL database
zplug "larkery/zsh-histdb", use:"history-timer.zsh", as:plugin
zplug "larkery/zsh-histdb", use:"sqlite-history.zsh", as:plugin

# Use the spaceship-zsh-theme
zplug "denysdovhan/spaceship-zsh-theme", use:"spaceship.zsh", from:github, as:theme

# zplug check returns true if all packages are installed
# Therefore, when it returns false, run zplug install
if ! zplug check; then
  zplug install
fi

# source plugins and add commands to the PATH
zplug load

#########################################
#      Spaceship zsh theme options      #
#########################################

# Order
SPACESHIP_PROMPT_ORDER=(
  user
  host
  docker
  dir
  git
  hg
  line_sep
  vi_mode
  char
)


SPACESHIP_PROMPT_PREFIXES_SHOW=true
SPACESHIP_PROMPT_SUFFIXES_SHOW=true
SPACESHIP_USER_SHOW=true
SPACESHIP_USER_SUFFIX=""
SPACESHIP_HOST_SHOW=true
SPACESHIP_HOST_PREFIX="@"
SPACESHIP_HOST_SUFFIX=""
SPACESHIP_DIR_SHOW=true
SPACESHIP_DIR_PREFIX=" "
SPACESHIP_DIR_SUFFIX=""
SPACESHIP_DIR_TRUNC=2
SPACESHIP_GIT_SHOW=true
SPACESHIP_GIT_PREFIX=" "
SPACESHIP_GIT_SUFFIX=""
SPACESHIP_GIT_BRANCH_SHOW=true
SPACESHIP_GIT_BRANCH_PREFIX="["
SPACESHIP_GIT_BRANCH_SUFFIX="]"
SPACESHIP_GIT_STATUS_SHOW=true
SPACESHIP_GIT_STATUS_PREFIX=" "
SPACESHIP_GIT_STATUS_SUFFIX=""
SPACESHIP_HG_SHOW=true
SPACESHIP_HG_BRANCH_SHOW=true
SPACESHIP_HG_STATUS_SHOW=true
SPACESHIP_DOCKER_SHOW=true
SPACESHIP_VI_MODE_SHOW=true
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_EXEC_TIME_SHOW=false
