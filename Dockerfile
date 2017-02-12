FROM fedora:25
MAINTAINER Gerard Braad <me@gbraad.nl>

RUN dnf update -y && \
    dnf clean all

ENV HOME=/home/user \
    USERNAME=user \
    UID=1000 \
    WORKSPACE=/home/user/Steam

# Create user, make root folder and change ownership
RUN mkdir -p ${HOME} && \
    chown -R ${UID}:0 ${HOME} && \
    adduser ${USERNAME} -u ${UID} -g 0 -r -m -d ${HOME} -c "Default Application User" -l

RUN dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-25.noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-25.noarch.rpm && \
    dnf install -y "dnf-command(config-manager)" && \
    dnf config-manager --add-repo=http://negativo17.org/repos/fedora-steam.repo && \
    dnf clean all

RUN dnf install -y steam && \
    dnf clean all

USER ${UID}

# Create  user's workspace
RUN mkdir -p ${WORKSPACE} && \
    mkdir -p ${HOME}/.local/share && \
    ln -sf ${WORKSPACE} ${HOME}/.local/share/steam && \
    cd ${WORKSPACE}

WORKDIR ${WORKSPACE}
VOLUME ${WORKSPACE}

