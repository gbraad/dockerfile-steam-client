FROM fedora:25
MAINTAINER Gerard Braad <me@gbraad.nl>

RUN dnf update -y && \
    dnf clean all

RUN dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-25.noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-25.noarch.rpm && \
    dnf install -y "dnf-command(config-manager)" && \
    dnf config-manager --add-repo=http://negativo17.org/repos/fedora-steam.repo && \
    dnf clean all

RUN dnf install -y steam && \
    dnf clean all
