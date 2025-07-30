#!/bin/sh

set -eu

stow() {
    command stow --restow --target="$HOME" "$1"
}

stow_ephemeral() {
    command mkdir --parents "$2"
    stow "$1"
}

stow git
stow profile
stow zsh

stow_ephemeral gnupg "$HOME/.gnupg"

stow_ephemeral dconf      "$HOME/.config/dconf"
stow_ephemeral fontconfig "$HOME/.config/fontconfig"
stow_ephemeral gtk-3.0    "$HOME/.config/gtk-3.0"
