# vim:ft=sh:
if [ -r ~/.profile ]; then
  source ~/.profile
fi

export HISTCONTROL=ignoredups
export EDITOR=vim

PATH=~/bin:"$PATH"
PATH=bin:"$PATH"
export PATH

bash_completion="$(brew --prefix 2>/dev/null)/etc/bash_completion"
if [ -r "$bash_completion" ]; then
  source "$bash_completion"
fi
unset bash_completion

# Set terminal title
title() {
  echo -n -e "\033]0;${@}\007"
}

_git_prompt() {
  local ref="$(command git symbolic-ref -q HEAD 2>/dev/null)"
  if [ -n "$ref" ]; then
    echo " (${ref#refs/heads/})"
  fi
}

_failed_status() {
  [ "$PIPESTATUS" -ne 0 ] && printf "$"
}

_success_status() {
  [ "$PIPESTATUS" -eq 0 ] && printf "$"
}

PS1='\[\e[0;31m\]\w\[\e[m\]$(_git_prompt) \[\e[1;31m\]$(_failed_status)\[\e[m\]$(_success_status) '
