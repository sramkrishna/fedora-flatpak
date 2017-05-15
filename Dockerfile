FROM fedora:25
MAINTAINER Alberto Fanjul <albertofanjul@gmail.com>

# Update Image and Install flatpak packages
RUN dnf -y update && dnf -y install ostree && dnf -y install flatpak flatpak-builder git 

# Install gnome runtimes
ENV FLATPAK_OSTREE_REPO_MODE=user-only
RUN flatpak remote-add --from gnome-nightly https://sdk.gnome.org/gnome-nightly.flatpakrepo && flatpak install gnome-nightly org.gnome.Sdk && flatpak install gnome-nightly org.gnome.Platform

ARG user=flatpak
RUN useradd --create-home --shell '/bin/bash' $user && \
    usermod $user -a -G wheel

RUN chown flatpak.flatpak /home/$user
RUN dnf -y install bubblewrap

WORKDIR /home/$user
USER $user

RUN git clone git://git.gnome.org/gnome-builder
COPY test-builder.sh /home/$user/gnome-builder

WORKDIR /home/$user/gnome-builder

#ENTRYPOINT ["/bin/bash"]
CMD ["bash"]
