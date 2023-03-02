# Honor per-interactive-shell startup file
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi

export GUIX_PROFILE="$HOME/.guix-profile"
export GUIX_LOCPATH="$HOME/.guix-profile/lib/locale"
export PATH="$PATH:$HOME/.config/guix/current:$HOME/.bin"
. "$GUIX_PROFILE/etc/profile"
