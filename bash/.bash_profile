#!/bin/bash
[ -f ~/.bashrc ] && . ~/.bashrc

[ -d "${HOME}/opt/go1.26.0" ] && export GOROOT="${HOME}/opt/go1.26.0"
[ -d "${HOME}/opt/go" ] && export GOPATH="${HOME}/opt/go"
[ -d "${GOROOT}" ] && export PATH="${GOROOT}/bin:${PATH}"
[ -d "${GOPATH}" ] && export PATH="${GOPATH}/bin:${PATH}"

[ -d "${HOME}/.local/share/pnpm" ] && export PNPM_HOME="${HOME}/.local/share/pnpm"
[ -d "${PNPM_HOME}" ] && export PATH="$PNPM_HOME:$PATH"

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

export XDG_SESSION_TYPE=tty
export EDITOR="emacsclient --no-window-system"
export VISUAL="emacsclient --no-window-system"
