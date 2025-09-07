#!/usr/bin/env sh

set -eu

stow() {
  package=$1
  target=$2

  echo "stow --no-folding --restow --target=${target} ${package}"
  command stow --no-folding --restow --target="${target}" "${package}"
}

stow darkman    "${HOME}"
stow emacs      "${HOME}"
stow fontconfig "${HOME}"
stow gh         "${HOME}"
stow git        "${HOME}"
stow gnupg      "${HOME}"
stow profile    "${HOME}"
stow sway       "${HOME}"
stow systemd    "${HOME}"
stow waybar     "${HOME}"
stow wezterm    "${HOME}"
stow xdg        "${HOME}"
stow zsh        "${HOME}"
