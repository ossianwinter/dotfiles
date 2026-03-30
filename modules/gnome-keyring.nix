{ config, lib, ... }:
{
  services.gnome.gnome-keyring.enable = true;

  xdg.portal.config.common = {
    "org.freedesktop.impl.portal.Secret" = lib.mkIf config.services.gnome.gnome-keyring.enable (
      lib.mkDefault [ "gnome-keyring" ]
    );
  };
}
