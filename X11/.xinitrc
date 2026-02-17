#!/bin/sh
[ -f ~/.xprofile ] && . ~/.xprofile
exec emacsclient --create-frame
