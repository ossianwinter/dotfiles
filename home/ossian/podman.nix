{ ... }:
{
  xdg.configFile."containers" = {
    source = ./podman/containers;
    recursive = true;
  };

  home.file.".testcontainers.properties".text = ''
    docker.host=unix:///run/user/$XDG_RUNTIME_DIR/podman/podman.sock
  '';
}
