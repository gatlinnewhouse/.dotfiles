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

# No tab completion beep
unsetopt LIST_BEEP

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
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history

# Keybinds for kitty
bindkey '\e[H'  beginning-of-line
bindkey '\e[F'  end-of-line
bindkey '\e[3~' delete-char

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# Load modules:
autoload -Uz compinit promptinit
# Command completion
compinit

# Completion for kitty
kitty + complete setup zsh | source /dev/stdin

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
export ALSA_CARD=PCH
# 20 seconds auto notify
export AUTO_NOTIFY_THRESHOLD=20
# auto expire after 3s
export AUTO_NOTIFY_EXPIRE_TIME=1500
# do not notify these programs
export AUTO_NOTIFY_IGNORE=("vim" "man" "sleep" "nvim" "nano" "sudo" "steam" "steam-native")
export BROWSER="waterfox"
export CLUTTER_BACKEND=wayland
export CCACHE_DIR="/var/tmp/ccache"
export EDITOR="nvim"
export ECORE_EVAS_ENGINE=wayland-egl
export ELM_ENGINE=wayland_egl
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export GDK_CORE_DEVICE_EVENTS=1
#export GDK_DPI_SCALE=0.5
export GDK_SCALE=2
#unset GIT_ASKPASS
export GIT_ASKPASS=
export GLFW_IM_MODULE=ibus
export GO_ENV="$HOME/.goenvs"
export GOPATH="$HOME/.go"
export GST_VAAPI_ALL_DRIVERS=1
export GTK_IM_MODULE=ibus
export GTK_IM_MODULE_FILE=/usr/lib/gtk-3.0/3.0.0/immodules.cache
export HISTSIZE=10000
export _JAVA_OPTIONS='-Dsun.java2d.opengl=true -Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
export _JAVA_AWT_WM_NONREPARENTING=1
export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
export LESS='-R '
export LIBVA_DRIVER_NAME=i965
export LOGNAME="godel"
export MOZ_ENABLE_WAYLAND=1
export MOZ_WEBRENDER=1
export MOZ_DBUS_REMOTE=1
##export MESA_LOADER_DRIVER_OVERRIDE=iris
export NO_AT_BRIDGE=1
export PATH="/usr/local/bin:$PATH"
export QT_QPA_PLATFORM=wayland-egl
export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_IM_MODULE=ibus
export SAVEHIST=10000
export SDL_VIDEODRIVER=wayland
export STEAM_RUNTIME=1
export SHELL="/bin/zsh"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
#unset SSH_ASKPASS
#export SSH_ASKPASS=
export SSH_CONNECTION="rhizome"
export SSH_KEY_PATH="~/.ssh/id_ed25519"
export SWAYSHOT_SCREENSHOTS="~/Pictures/Screenshots"
export TZ='America/Los_Angeles'
export VDPAU_DRIVER='va_gl'
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=sway
export XDG_CURRENT_DESKTOP=sway
export XDG_CONFIG_HOME="$HOME/.config"
export XMODIFIERS=@im=ibus
export WINEDEBUG=+relay,-debug
export WINESYNC=1

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
pathadd $HOME/.gem/ruby/2.6.0/bin
pathadd $HOME/.bin
pathadd /usr/lib/ccache/bin
pathadd $HOME/.cargo/bin

# Source files
source ~/.aliases
source ~/.inputrc
source ~/.local/share/icons-in-terminal/icons_bash.sh
source /etc/bash_completion.d/climate_completion
source $HOME/.zplugin/bin/zplugin.zsh

###########################################
#              Z-Plugin loading           #
###########################################

source '/home/gatnewhou/.zplugin/bin/zplugin.zsh'
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

###########################################
#              Z-Plugin Plugins           #
###########################################

# Load revolver
#zplugin load molovo/revolver

# Load zunit
#zplugin ice atpull"./build.zsh && cp zunit $HOME/.bin/zunit"
#zplugin light zunit-zsh/zunit

# Load auto-notifications for long running commands
zplugin load MichaelAquilina/zsh-auto-notify

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

# Load SSH plugin from OMZ
zplugin snippet OMZ::plugins/ssh-agent/ssh-agent.plugin.zsh

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

# Load github cli completions
zplugin ice pick'cli.zsh'; zplugin light sudosubin/zsh-github-cli


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
