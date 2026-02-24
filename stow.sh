#!/bin/sh
set -eu

stow() {
    package=$1
    target=$2
    command stow --no-folding --restow --target="${target}" "${package}"
}

stow X11                "${HOME}"
stow bash               "${HOME}"
stow dbus               "${HOME}"
stow emacs              "${HOME}"
stow fontconfig         "${HOME}"
stow git                "${HOME}"
stow gnupg              "${HOME}"
stow gtk-3.0            "${HOME}"
stow gtk-4.0            "${HOME}"
stow pipewire           "${HOME}"
stow readline           "${HOME}"
stow turnstile          "${HOME}"
stow xdg-desktop-portal "${HOME}"
