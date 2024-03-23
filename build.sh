#!/usr/bin/env bash
docker build -t wezterm-builder-c7:latest .

WEZTERM_TAG=20240203-110809-5046fc22
docker run --rm -v ./wezterm-build:/wezterm-build wezterm-builder-c7:latest /bin/bash -c "
    curl -LO https://github.com/wez/wezterm/releases/download/${WEZTERM_TAG}/wezterm-${WEZTERM_TAG}-src.tar.gz
    tar -xzf wezterm-${WEZTERM_TAG}-src.tar.gz
    cd wezterm-${WEZTERM_TAG}
    source /opt/rh/devtoolset-9/enable
    source /root/.cargo/env
    ./get-deps
    cargo build --release --no-default-features

    tar -zcvf /wezterm-build/wezterm-c7-minimal-${WEZTERM_TAG}.tar.gz \
        -C /wezterm-build/release \
        ./wezterm \
        ./wezterm-gui \
        ./wezterm-mux-server
"
