#!/usr/bin/env sh

# @Note: assume XDG_RUNTIME_DIR is set, can't be bothered doing substitution
# shellcheck disable=SC2154
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"
