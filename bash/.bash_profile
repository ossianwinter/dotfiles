#!/bin/bash
[ -f ~/.bashrc ] && . ~/.bashrc

export XDG_SESSION_TYPE=tty
export EDITOR="emacsclient --no-window-system"
export VISUAL="emacsclient --no-window-system"

[ -d "${HOME}/.local/bin" ] && export PATH="${HOME}/.local/bin:${PATH}"

[ -d "${HOME}/.local/share/pnpm" ] && export PNPM_HOME="${HOME}/.local/share/pnpm"
[ -d "${PNPM_HOME}" ] && export PATH="$PNPM_HOME:$PATH"
