# Honor per-interactive-shell startup file
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi
export LANG=cs_CZ.utf-8
export PATH=$PATH:$HOME/.bin

if [ ! -f /.dockerenv ] && [ ! -f /run/.containerenv ] && [ -d "$HOME/.guix-profile" ]; then
    # source "$HOME/.guix-profile/etc/profile"
    # source "$HOME/.config/guix/current/etc/profile"
    export PATH="$PATH:$HOME/.guix-profile/bin"
    export XDG_DATA_DIRS="$XDG_DATA_DIRS:$HOME/.guix-profile/share"
    export GUIX_LOCPATH="$HOME/.guix-profile/lib/locale"
fi

# if [[ "$(tty)" == "/dev/tty1" ]]
# then
#     export XDG_CURRENT_DESKTOP=sway
#     exec dbus-run-session -- sway
# fi
