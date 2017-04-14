# Oh-My-Zsh : Papercolor
# Modified by : Gatlin Newhouse

eval red='$fg[red]'
eval green='$fg[green]'
eval yellow='$fg[yellow]'
eval blue='$fg[blue]'
eval magenta='$fg[magenta]'
eval cyan='$fg[cyan]'
eval white='$fg[white]'
eval grey='$fg[grey]'

PROMPT='$(_user_host)${_current_dir}$(git_prompt_info)%{$reset_color%}$%{$reset_color%} '
RPROMPT=''

local _current_dir="%{$green%}%1~%{$reset_color%} "
local _return_status="%{$red%}%(?..×)%{$reset_color%}"
local _hist_no="%{$grey%}%h%{$reset_color%}"

function _user_host() {
  echo "%{$red%}%n%{$reset_color%}@%{$yellow%}%m%{$reset_color%} "
}

if [[ $USER == "root" ]]; then
  CARETCOLOR="$red"
else
  CARETCOLOR="$reset_color"
fi

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$reset_color%}%{$blue%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}%{$blue%}] %{$reset_color%}"

ZSH_THEME_GIT_PROMPT_DIRTY=" %{$red%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$green%}✔%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_ADDED=" %{$cyan%}✚%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_MODIFIED=" %{$yellow%}⚑%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DELETED=" %{$red%}✖%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_RENAMED=" %{$magenta%}▴%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED=" %{$red%}§%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED=" %{$yellow%}◒%{$reset_color%}"

# LS colors, made with http://geoff.greer.fm/lscolors/
export LSCOLORS="exfxcxdxbxegedabagacad"
export LS_COLORS='di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'
export GREP_COLOR='1;33'

# zsh history substring search colors
# HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND = '%{$BG[225]%}%{$FG[124]%}'
# HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND = '%{$FG[162]%}'
