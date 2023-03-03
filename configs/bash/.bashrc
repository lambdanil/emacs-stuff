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

clean_build () { # clear guix build by regex
    if [[ $1 ]]; then
	CLEAR_BUILD_PATHS="$(ls --color=never -d /gnu/store/$1 | tr '\n' ' ')"
    else
	echo "no regex specified"
	return 1
    fi
    if [[ $(echo "$CLEAR_BUILD_PATHS" | wc -c) -ne 1 ]]; then
	guix gc --delete $CLEAR_BUILD_PATHS
    else
	echo "no match for regex found"
	return 1
    fi
}

test -s ~/.alias && . ~/.alias || true
if [[ $- == *i* ]]
then
  _GREEN="\e[0;32m"
  _MAGENTA="\e[0;35m"
  _BLUE="\e[0;34m"
  _RED="\e[0;31m"
  _CYAN="\e[0;36m"
  _RESET="\e[0m"
  _BOLD="\e[1m"
#  export LD_LIBRARY_PATH=$LIBRARY_PATH
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

export XDG_DATA_DIRS="/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share:$XDG_DATA_DIRS"
export GUIX_PACKAGE_PATH="/etc/guix-modules"
