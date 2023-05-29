# Honor per-interactive-shell startup file
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi

if [ ! -f /.dockerenv ] && [ ! -f /run/.containerenv ] && [ -d "$HOME/.guix-profile" ]; then
    export GUIX_PROFILE="$HOME/.guix-profile"
    export GUIX_LOCPATH="$HOME/.guix-profile/lib/locale"
    export PATH="$HOME/.config/guix/current/bin:$HOME/.bin:$HOME/.local/share/flatpak/exports/bin:$PATH"
    export SSL_CERT_DIR="$HOME/.guix-profile/etc/ssl/certs"
    export SSL_CERT_FILE="$HOME/.guix-profile/etc/ssl/certs/ca-certificates.crt"
    export GIT_SSL_CAINFO="$SSL_CERT_FILE"
    export XDG_DATA_DIRS="$XDG_DATA_DIRS:$HOME/.guix-profile/share"
    . "$GUIX_PROFILE/etc/profile"
fi

# if [[ "$(tty)" == "/dev/tty1" ]]
# then
#     exec sway
# fi
