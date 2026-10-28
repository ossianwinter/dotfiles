# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

# Don't save duplicates to history
HISTCONTROL=ignoredups

# Append to the history file instead of overwriting
shopt -s histappend

# Fancy prompt with colors if supported
if command -v tput &>/dev/null && (( $(tput colors 2>/dev/null || echo 0) >= 8 )); then
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='\u@\h:\w\$ '
fi

alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

eval "$(direnv hook bash)"
