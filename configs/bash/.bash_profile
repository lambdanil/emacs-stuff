# Honor per-interactive-shell startup file
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi

if [ ! -f /.dockerenv ] && [ ! -f /run/.containerenv ] && [ -d "$HOME/.guix-profile" ]; then
    source "$HOME/.guix-profile/etc/profile"
    source "$HOME/.config/guix/current/etc/profile"
fi

# if [[ "$(tty)" == "/dev/tty1" ]]
# then
#     exec sway
# fi
