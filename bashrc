# Sample .bashrc for SUSE Linux
# Copyright (c) SUSE Software Solutions Germany GmbH

# There are 3 different types of shells in bash: the login shell, normal shell
# and interactive shell. Login shells read ~/.profile and interactive shells
# read ~/.bashrc; in our setup, /etc/profile sources ~/.bashrc - thus all
# settings made here will also take effect in a login shell.
#
# NOTE: It is recommended to make language settings in ~/.profile rather than
# here, since multilingual X sessions would not work properly if LANG is over-
# ridden in every subshell.

test -s ~/.alias && . ~/.alias || true
PATH=$PATH:$HOME/.bin
_GREEN=$(tput setaf 2)
_MAGENTA=$(tput setaf 200)
_BLUE=$(tput setaf 4)
_RED=$(tput setaf 1)
_CYAN=$(tput setaf 45)
_RESET=$(tput sgr0)
_BOLD=$(tput bold)
export PS1="[${_MAGENTA}\u${_RESET}@${_CYAN}\h${_RESET}] \t\n(\w) λ \[$(tput sgr0)\]"
# export PS1="[\u@\h] \t\n(\w) λ \[$(tput sgr0)\]"
alias ls="ls --color"
alias flatpak="sudo flatpak"
