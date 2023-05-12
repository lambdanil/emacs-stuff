# Honor per-interactive-shell startup file
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi

if [ ! -f /.dockerenv ] && [ ! -f /run/.containerenv ]; then
    export GUIX_PROFILE="$HOME/.guix-profile"
    export GUIX_LOCPATH="$HOME/.guix-profile/lib/locale"
    export PATH="$HOME/.config/guix/current/bin:$HOME/.bin:$HOME/.local/share/flatpak/exports/bin:$PATH"
    . "$GUIX_PROFILE/etc/profile"
fi
