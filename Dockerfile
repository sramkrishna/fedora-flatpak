FROM fedora:25
MAINTAINER Alberto Fanjul <albertofanjul@gmail.com>

# Install flatpak packages
RUN dnf -y update
RUN dnf -y install flatpak flatpak-builder git

# Install gnome runtimes
RUN flatpak remote-add --from gnome-nightly https://sdk.gnome.org/gnome-nightly.flatpakrepo
RUN flatpak install gnome-nightly org.gnome.Sdk
RUN flatpak install gnome-nightly org.gnome.Platform

CMD ["bash"]
