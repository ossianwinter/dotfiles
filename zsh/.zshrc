# don't create a history file
HISTFILE=
SAVEHIST=

# save, in the current zsh instance, up to 1000 lines
HISTSIZE=1000

# use home relative path in prompt
PROMPT="%3~ %# "

# default emacs binds are (mostly) fine
bindkey -e
bindkey ";5C" emacs-forward-word
bindkey ";5D" emacs-backward-word

# comp
autoload -Uz compinit
compinit

alias ls="ls --almost-all --color=auto"
