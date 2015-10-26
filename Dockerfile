from debian:jessie


RUN apt-get update && \
    apt-get install -qqy --force-yes \
            curl \
            flex \
            bison texinfo \
            libelf-dev \
            autoconf \
            git \
            python \
            build-essential \
            libncurses5-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

add patches /opt/arm-ebai-toolchain/patches
add Makefile /opt/arm-ebai-toolchain/
workdir /opt/arm-ebai-toolchain
run PREFIX=/opt/arm-cs-tools make arm-2014.05 arm-2014.05-28-arm-none-eabi.src.tar.bz2
run PREFIX=/opt/arm-cs-tools make cross-binutils
run PREFIX=/opt/arm-cs-tools make cross-gcc
run PREFIX=/opt/arm-cs-tools make cross-gdb
run PREFIX=/opt/arm-cs-tools make install-cross
run PREFIX=/opt/arm-cs-tools make install-bin-extras
run PREFIX=/opt/arm-cs-tools make clean && \
    rm -rf /opt/arm-ebai-toolchain

workdir /opt/arm-ebai-toolchain

env PATH /opt/arm-cs-tools/bin:$PATH
