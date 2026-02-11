ARG version=18.04

FROM ubuntu:$version

LABEL org.opencontainers.image.source="https://github.com/OSSystems/docker-yocto-env"
LABEL org.opencontainers.image.description="Yocto Project development environment"

# Does prevent interactive questions on apt operations
ARG DEBIAN_FRONTEND=noninteractive

# Install the required packages for development. We do this in a single command
# so the cache of the layer is handled atomically.
#
# The `realpath` is specific for Ubuntu 14.04 as later it was included in
# `coreutils` package.
RUN apt-get update && \
    # Optional packages (may not exist on all Ubuntu versions)
    apt-get install -y --no-install-recommends realpath || true && \
    apt-get install -y --no-install-recommends python python-dev || true && \
    apt-get install -y --no-install-recommends python3 python3-dev || true && \
    apt-get install -y --no-install-recommends python3-distutils-extra || true && \
    apt-get install -y --no-install-recommends python-dev-is-python3 || true && \
    apt-get install -y --no-install-recommends libegl1-mesa || true && \
    apt-get install -y --no-install-recommends \
        # Yocto Project core build dependencies
        build-essential \
        ca-certificates \
        chrpath \
        cpio \
        debianutils \
        diffstat \
        file \
        gawk \
        git-core \
        locales \
        openssh-client \
        openssl \
        python3-git \
        python3-lxml \
        texinfo \
        unzip \
        wget \
        xz-utils \
        zstd \
        # Kernel build dependencies
        bc \
        bison \
        device-tree-compiler \
        flex \
        libssl-dev \
        lzop \
        swig \
        # Development libraries
        glib-2.0-dev \
        libncurses-dev \
        liblz4-tool \
        libsdl1.2-dev \
        # Multilib support
        g++-multilib \
        gcc-multilib \
        # Networking and system tools
        curl \
        iproute2 \
        iptables \
        iputils-ping \
        jq \
        procps \
        socat \
        sudo \
        # General utilities
        bash \
        git-lfs \
        less \
        nano \
        rpm \
        tmux \
        xterm \
        zsh \
        && \
    rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

WORKDIR /
COPY --chmod=755 entrypoint.sh .
COPY --chmod=755 yocto-env .

ENTRYPOINT ["/entrypoint.sh"]
