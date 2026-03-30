{ config, ... }:
{
  services.gnome-keyring = {
    enable = true;
    components = [ "secrets" ];
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ config.services.gnome-keyring.package ];
    config.common = {
      "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
    };
  };
}
