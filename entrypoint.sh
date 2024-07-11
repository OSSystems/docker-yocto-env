#!/bin/bash

case "$1" in
    wrapper)
        cat yocto-env
        exit 0
        ;;
    run)
        USER_UID=${HOST_UID:=$UID}
        USER_GID=${HOST_GID:=$GID}

        awk -F : "\$3 == ${USER_UID} { print \$1 }" /etc/passwd | xargs userdel
        groupmod -g ${USER_GID} users
        useradd ${USER} \
                -s /bin/bash \
                -m \
                --uid ${USER_UID} --gid ${USER_GID} > /dev/null 2>&1

        echo 'ALL ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers

        exec sudo --preserve-env -H -u ${USER} /bin/$(basename $SHELL)
        ;;
    "")
        cat > /dev/stderr <<EOF
Yocto Project Environment helper

This container is self-contained and we provide the wrapper script
inside it. To get it please run this very same container passing
wrapper as argument. For example:

    docker run ossystems/yocto-env:20.04 wrapper > ~/bin/yocto-env
    chmod a+x ~/bin/yocto-env

EOF
        exit 1
esac
