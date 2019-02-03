#########################################
#              Zsh Settings             #
#########################################

# if you do a 'rm *', Zsh will give you a sanity check!
setopt RM_STAR_WAIT

# Autocomplete with arrow-key interface
# and persistent rehashing for updating and adding new items to $PATH
zstyle ':completion:*' menu select 
zstyle ':completion:*' rehash true
# Aliases too
setopt COMPLETE_ALIASES

# Use a prompt
setopt promptsubst

# Enable zsh history search
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Write to history immediately
setopt inc_append_history
# Save extended info in history
setopt extended_history
# Ignore duplicate entries in history
setopt hist_ignore_dups

# turn off ZLE bracketed paste in dumb term
# otherwise turn on ZLE bracketed-paste-magic
if [[ $TERM == dumb ]]; then
    unset zle_bracketed_paste
else
    autoload -Uz bracketed-paste-magic
    zle -N bracketed-paste bracketed-paste-magic
fi

# Set zsh to EMACs mode
bindkey -e

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]="$terminfo[khome]"
key[End]="$terminfo[kend]"
key[Insert]="$terminfo[kich1]"
key[Backspace]="$terminfo[kbs]"
key[Delete]="$terminfo[kdch1]"
key[Up]="$terminfo[kcuu1]"
key[Down]="$terminfo[kcud1]"
key[Left]="$terminfo[kcub1]"
key[Right]="$terminfo[kcuf1]"
key[PageUp]="$terminfo[kpp]"
key[PageDown]="$terminfo[knp]"

# setup key accordingly
[[ -n "$key[Home]"      ]] && bindkey -- "$key[Home]"      beginning-of-line
[[ -n "$key[End]"       ]] && bindkey -- "$key[End]"       end-of-line
[[ -n "$key[Insert]"    ]] && bindkey -- "$key[Insert]"    overwrite-mode
[[ -n "$key[Backspace]" ]] && bindkey -- "$key[Backspace]" backward-delete-char
[[ -n "$key[Delete]"    ]] && bindkey -- "$key[Delete]"    delete-char
[[ -n "$key[Up]"        ]] && bindkey -- "$key[Up]"        up-line-or-beginning-search
[[ -n "$key[Down]"      ]] && bindkey -- "$key[Down]"      down-line-or-beginning-search
[[ -n "$key[Left]"      ]] && bindkey -- "$key[Left]"      backward-char
[[ -n "$key[Right]"     ]] && bindkey -- "$key[Right]"     forward-char

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        echoti smkx
    }
    function zle-line-finish () {
        echoti rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

# Load modules:
autoload -Uz compinit promptinit
# Command completion
compinit
# Load fancy prompt
promptinit

# Enable colors
autoload -U colors zsh/terminfo
colors

# Enable help
autoload -Uz run-help
# Enable help commands
autoload -Uz run-help-git
autoload -Uz run-help-ip
autoload -Uz run-help-openssl
autoload -Uz run-help-p4
autoload -Uz run-help-sudo
autoload -Uz run-help-svk
autoload -Uz run-help-svn

#########################################
#      Paths, Sources, & Variables      #
#########################################

# Function for adding stuff to path
pathadd() {
  [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]] && PATH="${PATH:+"$PATH:"}$1"
}

# Export environmental variables
export BROWSER="waterfox"
export CCACHE_DIR="/var/tmp/ccache"
export EDITOR="nvim"
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export GO_ENV="$HOME/.goenvs"
export GOPATH="$HOME/.go"
export GTK_IM_MODULE=ibus
export GTK_IM_MODULE_FILE=/usr/lib/gtk-3.0/3.0.0/immodules.cache
export HISTSIZE=10000
export _JAVA_OPTIONS='-Dsun.java2d.opengl=true -Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
export LESS='-R '
export LIBVA_DRIVER_NAME=i965
export LOGNAME="godel"
export PATH="/usr/local/bin:$PATH"
export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export QT_IM_MODULE=ibus
export SAVEHIST=10000
export STEAM_RUNTIME=1
export SHELL="/bin/zsh"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export SSH_CONNECTION="rhizome"
export SSH_KEY_PATH="~/.ssh/rsa_id"
export VDPAU_DRIVER='va_gl'
export XDG_CONFIG_HOME="$HOME/.config"
export XMODIFIERS=@im=ibus
export WINEDEBUG=+relay,-debug

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
pathadd $HOME/.go/bin
pathadd $HOME/.gem/ruby/2.4.0/bin
pathadd $HOME/.bin/
pathadd /usr/lib/ccache/bin/

# Source files
source ~/.aliases
source ~/.inputrc
source ~/.local/share/icons-in-terminal/icons_bash.sh
source /etc/bash_completion.d/climate_completion
source $HOME/.zplugin/bin/zplugin.zsh

###########################################
#              Z-Plugin loading           #
###########################################

source '/home/deleuze/.zplugin/bin/zplugin.zsh'
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

###########################################
#              Z-Plugin Plugins           #
###########################################

# Load history search multiword
zplugin load zdharma history-search-multi-word

# Load zplugin UI
zplugin ice compile"*.lzui" from"notabug"
zplugin load zdharma/zui

# Load zsh autosuggestions
zplugin light zsh-users/zsh-autosuggestions

# Fish-like syntax highlighting for zsh
zplugin light zdharma/fast-syntax-highlighting

# Oh-my-zsh colored-man-pages
zplugin snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh

# Oh-my-zsh per-directory-history
zplugin snippet OMZ::plugins/per-directory-history/per-directory-history.zsh

# 256 ZSH Color
zplugin ice pick"zsh-256color.plugin.zsh"; zplugin light chrissicool/zsh-256color

# Safe pasting
zplugin ice pick"safe-paste.plugin.zsh"; zplugin light oz/safe-paste

# Load OMZ Git library
zplugin snippet OMZ::lib/git.zsh

# Load Git plugin from OMZ
zplugin snippet OMZ::plugins/git/git.plugin.zsh
zplugin cdclear -q # <- forget completions provided up to this moment

setopt promptsubst

# Load theme from OMZ
zplugin snippet OMZ::themes/dstufft.zsh-theme

# Load normal Github plugin with theme depending on OMZ Git library
zplugin light denysdovhan/spaceship-prompt

# This one to be ran just once, in interactive session 
#zplugin creinstall %HOME/my_completions  # Handle completions without loading any plugin, see "clist" command

# Zsh completions
zplugin ice blockf
zplugin light zsh-users/zsh-completions

#########################################
#      Spaceship zsh theme options      #
#########################################

# Load the theme
ZSH_THEME="spaceship"

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
