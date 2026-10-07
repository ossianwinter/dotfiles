{ config, pkgs, ... }:
{
  services.gnome-keyring = {
    enable = true;
    components = [ "secrets" ];
  };

  home.packages = with pkgs; [ gcr_4 ];

  xdg.portal = {
    enable = true;
    extraPortals = [ config.services.gnome-keyring.package ];
    config.common = {
      "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
    };
  };
}
