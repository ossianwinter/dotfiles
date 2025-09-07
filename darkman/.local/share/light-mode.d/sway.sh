#!/usr/bin/env sh

ln -sf "${HOME}/.config/sway/light.conf" "${HOME}/.config/sway/theme.conf"
swaymsg reload
