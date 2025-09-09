#!/usr/bin/env sh

cmd=$1
key=$2
val=$3

swaymsg '['"${key}"'='"${val}"'] focus' || exec ${cmd}
