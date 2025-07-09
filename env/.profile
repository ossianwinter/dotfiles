# use less as default pager
export PAGER="/usr/bin/less"
export LESS="--raw-control-chars"

# use the gcr ssh agent
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gcr/ssh"

# prefer native wayland for Qt
export QT_QPA_PLATFORM="wayland;wcb"

# prefer native wayland for SDL
export SDL_VIDEODRIVER="wayland,x11"

# prefer native wayland for Electron
export ELECTRON_OZONE_PLATFORM_HINT="auto"

# fix misbehavior for Java
export _JAVA_AWT_WM_NONREPARENTING="1"
