FROM centos:7.9.2009
RUN yum -y update && \
    yum -y install epel-release &&  \
    yum -y group install development minimal && \
    yum -y install git && \
    yum -y install centos-release-scl-rh && \
    yum -y install devtoolset-9-gcc-c++

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain stable

ENV CARGO_TARGET_DIR /wezterm-build

WORKDIR /wezterm-src
