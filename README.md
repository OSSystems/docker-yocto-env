# Yocto Project Environment helper

This container is self-contained and we provide the wrapper script
inside it. To get it please run this very same container passing
wrapper as argument. For example:

    docker run ossystems/yocto-env:20.04 wrapper > ~/bin/yocto-env
    chmod a+x ~/bin/yocto-env

The generated wrapper, `yocto-env`, has the following usage message:

    USAGE:

      yocto-env <version> [--skip-pull]

    OPTIONS

      version           Environment version to use. This maps to Ubuntu releases
                        and currently it provides the 16.04, 18.04,
                        and 20.04, 22.04 and 24.04.


