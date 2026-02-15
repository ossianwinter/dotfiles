#!/bin/bash
[ -f ~/.bashrc ] && . ~/.bashrc

export EDITOR="emacsclient --no-window-system"
export VISUAL="emacsclient --no-window-system"

export PNPM_HOME="${HOME}/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
