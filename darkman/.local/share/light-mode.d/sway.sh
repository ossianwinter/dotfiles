#!/usr/bin/env sh

ln -sf "${HOME}/.config/sway/themes/light.conf" "${HOME}/.config/sway/themes/darkman.conf"
swaymsg reload
