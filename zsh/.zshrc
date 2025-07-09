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

# osc7 pwd support (foot)
autoload -Uz add-zsh-hook

function osc7-pwd() {
  emulate -L zsh # also sets localoptions for us
  setopt extendedglob
  local LC_ALL=C
  printf '\e]7;file://%s%s\e\' $HOST ${PWD//(#m)([^@-Za-z&-;_~])/%${(l:2::0:)$(([##16]#MATCH))}}
}

function chpwd-osc7-pwd() {
    (( ZSH_SUBSHELL )) || osc7-pwd
}

add-zsh-hook -Uz chpwd chpwd-osc7-pwd

alias ls="ls --almost-all --color=auto"
