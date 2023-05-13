# Honor per-interactive-shell startup file
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi

if [ ! -f /.dockerenv ] && [ ! -f /run/.containerenv ]; then
    export GUIX_PROFILE="$HOME/.guix-profile"
    export GUIX_LOCPATH="$HOME/.guix-profile/lib/locale"
    export PATH="$HOME/.config/guix/current/bin:$HOME/.bin:$HOME/.local/share/flatpak/exports/bin:$PATH"
    export SSL_CERT_DIR="$HOME/.guix-profile/etc/ssl/certs"
    export SSL_CERT_FILE="$HOME/.guix-profile/etc/ssl/certs/ca-certificates.crt"
    export GIT_SSL_CAINFO="$SSL_CERT_FILE"
    . "$GUIX_PROFILE/etc/profile"
fi
