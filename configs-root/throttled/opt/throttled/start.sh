#!/bin/sh
sudo guix shell gcc-toolchain pkg-config cairo gobject-introspection dbus -- /opt/throttled/venv/bin/python /opt/throttled/throttled.py --config /home/nil/conf/throttled.conf
