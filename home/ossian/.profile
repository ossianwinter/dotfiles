export EDITOR='emacsclient --no-window-system'
export VISUAL='emacsclient --no-window-system'
export XDG_SESSION_TYPE=tty

if [ -n "$BASH_VERSION" ]; then
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi
