#!/bin/bash
# Download and build a flatpak GNOME Builder
#
#
#

flatpak build-init builder org.gnome.Builder org.gnome.Sdk org.gnome.Platform master
flatpak-builder builder org.gnome.Builder.json --stop-at gnome-builder --force-clean
flatpak build builder ./autogen.sh --prefix=/app --enable-tracing --enable-debug --with-channel=flatpak-nightly
flatpak build builder make CFLAGS="-ggdb3 -O0"
flatpak build builder make install
flatpak build-finish --require-version=0.8.0 --allow=devel --talk-name=org.freedesktop.Flatpak --share=ipc --socket=x11 --socket=wayland --filesystem=home --filesystem=host --share=network --talk-name=org.gtk.vfs.* --system-talk-name=org.freedesktop.PolicyKit1 --system-talk-name=org.gnome.Sysprof2 --talk-name=org.gnome.CodeAssist.v1.* --filesystem=xdg-run/dconf --filesystem=~/.config/dconf:ro --talk-name=ca.desrt.dconf --env=DCONF_USER_CONFIG_DIR=.config/dconf --talk-name=org.freedesktop.FileManager1 --talk-name=org.freedesktop.PackageKit --talk-name=org.freedesktop.secrets --filesystem=xdg-run/keyring --env=SSL_CERT_DIR=/etc/ssl/certs --filesystem=/etc/ssl:ro --filesystem=/etc/pki:ro --filesystem=/etc/ca-certificates:ro --filesystem=~/.local/share/flatpak --filesystem=/var/lib/flatpak builder

