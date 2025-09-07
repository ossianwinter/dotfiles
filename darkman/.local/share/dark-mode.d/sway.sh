#!/usr/bin/env sh

ln -sf "${HOME}/.config/sway/dark.conf" "${HOME}/.config/sway/theme.conf"
swaymsg reload
