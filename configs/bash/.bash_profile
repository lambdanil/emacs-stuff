# Honor per-interactive-shell startup file
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi

if [ ! -f /.dockerenv ] && [ ! -f /run/.containerenv ] && [ -d "$HOME/.guix-profile" ]; then
    source "$HOME/.guix-profile/etc/profile"
    source "$HOME/.config/guix/current/etc/profile"
fi
# export PATH="$PATH:$HOME/.guix-profile/bin"
# export XDG_DATA_DIRS="$XDG_DATA_DIRS:$HOME/.guix-profile/share"

if [[ "$(tty)" == "/dev/tty1" ]]
then
    export XDG_CURRENT_DESKTOP=sway
    exec dbus-run-session -- sway
fi
