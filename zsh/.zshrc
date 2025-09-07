#!/usr/bin/env zsh

HISTFILE=/dev/null
SAVEHIST=0

PROMPT='%3~ %# '

alias ls='ls --almost-all --color=auto'

bindkey -e
bindkey ';5C' emacs-forward-word
bindkey ';5D' emacs-backward-word
