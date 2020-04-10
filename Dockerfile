FROM debian:10.3

# Does prevent interactive questions on apt operations
ENV DEBIAN_FRONTEND=noninteractive
ENV WORKSPACE=/opt/build

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        chrpath \
        cpio \
        debianutils \
        diffstat \
        file \
        gawk \
        gcc-multilib \
        git-core \
        glib-2.0-dev \
        iputils-ping \
        libegl1-mesa \
        libsdl1.2-dev \
        locales \
        pylint3 \
        python \
        python3 \
        python3-git \
        python3-jinja2 \
        python3-pexpect \
        python3-pip \
        socat \
        sudo \
        texinfo \
        unzip \
        wget \
        xterm \
        xz-utils \
        \
        procps && \
    /usr/sbin/locale-gen en_US.UTF-8 && \
    rm -rf /var/lib/apt/lists/*

# Set the locale
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN useradd -U -m -s /bin/bash builder && \
    mkdir -p ${WORKSPACE} && \
    chown -R builder:builder ${WORKSPACE} && \
    adduser builder root && \
    adduser builder sudo && \
    echo 'builder ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER builder

CMD []
ENTRYPOINT ["/bin/bash"]
