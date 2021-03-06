FROM ubuntu:18.04
LABEL maintainer="Alexey Sudachen <alexey@sudachen.name>"
ENV USER robot
ENV UID 1000
ENV GID 100
ENV HOME /$USER
ENV CPGPU cpu
ENV DEBIAN_FRONTEND noninteractive
ENV SHELL /bin/bash

ARG TZ=America/Santiago
ENV TZ $TZ

USER root
RUN bash -c "for i in {1..9}; do mkdir -p /usr/share/man/man\$i; done" \
 && echo 'APT::Get::Assume-Yes "true";' > /etc/apt/apt.conf.d/90noninteractive \
 && echo 'DPkg::Options "--force-confnew";' >> /etc/apt/apt.conf.d/90noninteractive \
 && echo 'PATH="$HOME/.local/bin:$PATH"' >> /etc/profile.d/user-path.sh \
 && apt-get update --fix-missing \
 && apt-get install -qy --no-install-recommends \
    ca-certificates \
    tzdata \
    locales \
    git \
    bash \
    sudo \
    unzip \
    bzip2 \
    p7zip-full \
    procps \
    make \
    curl \
    gnupg2 \
    ssh \
    apt-transport-https \
    openvpn \
    net-tools \
    netcat \
    iputils-ping \
    dnsutils \
    joe \
    file \
    screen \
    libgcc1 \
    libgomp1 \
    libstdc++6 \
    xz-utils \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && locale-gen en_US.UTF-8 \
 && update-locale LANG=en_US.UTF-8 \
 && echo "$TZ" > /etc/timezone \
 && useradd -m -s $SHELL -N -u $UID $USER -d $HOME \
 && chmod g+w /etc/passwd /etc/group \
 && chown $USER:users -R $HOME \
 && echo "$USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90$USER \
 && echo 'Defaults    env_keep += "DEBIAN_FRONTEND"' >> /etc/sudoers.d/env_keep \
 && echo 'Defaults    env_keep += "CPGPU"' >> /etc/sudoers.d/env_keep \
 && echo 'Defaults    env_keep += "TZ"' >> /etc/sudoers.d/env_keep \
 && echo 'Defaults    env_keep += "SHELL"' >> /etc/sudoers.d/env_keep \
 && echo 'Defaults    env_keep += "LANG"' >> /etc/sudoers.d/env_keep \
 && echo 'Defaults    env_keep += "LANGUAGE"' >> /etc/sudoers.d/env_keep \
 && echo 'Defaults    env_keep += "LC_ALL"' >> /etc/sudoers.d/env_keep

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

USER $USER
WORKDIR $HOME


