#_GREEN=$(tput setaf 2)
#_MAGENTA=$(tput setaf 200)
#_BLUE=$(tput setaf 4)
#_RED=$(tput setaf 1)
#_CYAN=$(tput setaf 45)
#_RESET=$(tput sgr0)
#_BOLD=$(tput bold) # use if tput available

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
if [[ $- == *i* ]]
then
  _GREEN="\e[0;32m"
  _MAGENTA="\e[0;35m"
  _BLUE="\e[0;34m"
  _RED="\e[0;31m"
  _CYAN="\e[0;36m"
  _RESET="\e[0m"
  _BOLD="\e[1m"
  export PS1="[${_MAGENTA}\u${_RESET}@${_CYAN}\h${_RESET}] \t\n(\w) λ "
fi
#export PS1="[\u@\h] \t\n(\w) λ "
alias ls="ls --color"

# Automatically added by the Guix install script.
if [ -n "$GUIX_ENVIRONMENT" ]; then
    if [[ $PS1 =~ (.*)"\\$" ]]; then
        PS1="${BASH_REMATCH[1]} [env]\\\$ "
    fi
fi

export GUIX_PROFILE="$HOME/.guix-profile"
export GUIX_LOCPATH="$HOME/.guix-profile/lib/locale"
export PATH="$PATH:$HOME/.config/guix/current"
. "$GUIX_PROFILE/etc/profile"
export XDG_DATA_DIRS="/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share:$XDG_DATA_DIRS"
