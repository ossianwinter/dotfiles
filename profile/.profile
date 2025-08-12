#!/bin/sh

export PATH="$PATH:$HOME/.cargo/bin"

export PAGER=/usr/bin/less
export LESS="--raw-control-chars --quit-if-one-screen"

export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

export GDK_BACKEND=wayland
export QT_QPA_PLATFORM=wayland
export SDL_VIDEODRIVER=wayland
export ELECTRON_OZONE_PLATFORM_HINT=wayland
