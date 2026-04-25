{ ... }:
{
  xdg.configFile."containers" = {
    source = ./podman/containers;
    recursive = true;
  };
}
