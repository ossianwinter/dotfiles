# in memory history
HISTSIZE=256

# on disk history
HISTFILE=/dev/null
SAVEHIST=0

# home relative prompt
PROMPT="%3~ %# "

alias ls="ls --almost-all --color=auto"

bindkey -e
bindkey ";5C" emacs-forward-word
bindkey ";5D" emacs-backward-word

zstyle ':completion:*' completer _complete _ignored
autoload -Uz compinit
compinit
