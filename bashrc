#!/bin/bash
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [[ $TERMINIX_ID ]]; then
  source /etc/profile.d/vte.sh
fi

function tmux {
  ~/.cache/the_dark_side/tmux -S /tmp/tmux
}
#tmux
#chmod 777 /tmp/tmux
alias dconf=~/.cache/the_dark_side/dconf
alias terminix=~/.cache/the_dark_side/terminix.bash
alias apm=~/.cache/the_dark_side/atom/resources/app/apm/bin/apm

export BASH_IT="$HOME/.cache/the_dark_side/bash_it"
export BASH_IT_THEME='powerline-multiline'
export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=''
unset MAILCHECK
export SCM_CHECK=true
export SCM_GIT_SHOW_DETAILS=true
export EDITOR=vim
source "$BASH_IT/bash_it.sh"

complete -d cd
