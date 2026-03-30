{ config, pkgs, ... }:
{
  services.darkman = {
    enable = true;
    settings = {
      lat = 57.7;
      lng = 11.9;
    };

    darkModeScripts = {
      gtk-theme = ''
        ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/color-scheme '"prefer-dark"'
      '';
    };

    lightModeScripts = {
      gtk-theme = ''
        ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/color-scheme '"prefer-light"'
      '';
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ config.services.darkman.package ];
    config.common = {
      "org.freedesktop.impl.portal.Settings" = [ "darkman" ];
    };
  };
}
