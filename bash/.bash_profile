#!/bin/bash
[ -f ~/.bashrc ] && . ~/.bashrc


[ -d "${HOME}/.local/share/pnpm" ] && export PNPM_HOME="${HOME}/.local/share/pnpm"
[ -d "${PNPM_HOME}" ] && export PATH="$PNPM_HOME:$PATH"

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

export XDG_SESSION_TYPE=tty
export EDITOR="emacsclient --no-window-system"
export VISUAL="emacsclient --no-window-system"
