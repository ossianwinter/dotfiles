#!/bin/sh

set -eu

stow() {
    command stow --no-folding --restow --target="$HOME" $@
}

stow dconf
stow emacs
stow fontconfig
stow foot
stow git
stow gnupg
stow gtk-3.0
stow gtk-4.0
stow profile
stow zsh
