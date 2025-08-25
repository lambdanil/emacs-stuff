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

if [ -n "$GUIX_ENVIRONMENT" ]; then
    if [[ $PS1 =~ (.*)"\\$" ]]; then
	  PS1="${BASH_REMATCH[1]} [env]\\\$ "
    fi
fi

if [[ $- == *i* ]]
then
    _GREEN=$(tput setaf 2)
    _MAGENTA=$(tput setaf 207)
    _BLUE=$(tput setaf 4)
    _RED=$(tput setaf 1)
    _CYAN=$(tput setaf 45)
    _RESET=$(tput sgr0)
    _BOLD=$(tput bold)
    # _GREEN="\e[0;32m"
    # _MAGENTA="\e[0;35m"
    # _BLUE="\e[0;34m"
    # _RED="\e[0;31m"
    # _CYAN="\e[0;36m"
    # _RESET="\e[0m"
    # _BOLD="\e[1m"
    #  export LD_LIBRARY_PATH=$LIBRARY_PATH
    export PS1="[${_MAGENTA}\u${_RESET}@${_CYAN}\h${_RESET}] \t\n(\w) λ "
fi

if [ ! -f /.dockerenv ] && [ ! -f /run/.containerenv ] && [ -d "$HOME/.guix-profile" ] && [[ $- == *i* ]]; then
    GUIX_PROFILE="$HOME/.guix-profile"
    . "$GUIX_PROFILE/etc/profile"
    GUIX_PROFILE="$HOME/.config/guix/current"
    . "$GUIX_PROFILE/etc/profile"
fi

alias sudo="sudo -p \"[sudo] what's youw p-pa-password, Nil-chan?~ ❤️  \" "
#  alias apt="nala"
  alias ls="ls --color"
  alias ld_libs="export LD_LIBRARY_PATH=\$LIBRARY_PATH"
  alias tf="xrandr --output HDMI-A-1 --set TearFree"
  alias hyfetch="hyfetch --ascii-file ~/git/neofetch-logo"
  alias deb="xhost +si:localuser:nil && distrobox enter debian --"
  alias glibc="bwrap --bind /var/chroots/debian / --dev /dev --proc /proc --bind /sys /sys  --ro-bind /sys/dev/char /sys/dev/char --ro-bind /sys/devices/pci0000:00 /sys/devices/pci0000:00 --bind /run /run --bind /home /home --ro-bind /dev/dri /dev/dri --ro-bind /etc/resolv.conf /etc/resolv.conf --ro-bind /etc/passwd /etc/passwd --ro-bind /etc/group /etc/group"
  alias glibc-root="doas chroot /var/chroots/debian /bin/bash"
  alias reconf="sudo -E guix system reconfigure /etc/guix-systems/$HOSTNAME.scm"

export XDG_DATA_DIRS="/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share:$XDG_DATA_DIRS"
export GUIX_PACKAGE_PATH="/etc/guix-modules"
export SUDO_PROMPT='[sudo] what'\''s youw p-pa-password, Nil-chan?~ ❤️  '
