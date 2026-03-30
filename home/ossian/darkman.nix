{ config, pkgs, ... }:
{
  services.darkman = {
    enable = true;

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
