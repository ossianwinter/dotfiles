{ lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ darkman ];

  xdg.portal.enable = lib.mkDefault true;
  xdg.portal.config.common = {
    "org.freedesktop.impl.portal.Settings" = lib.mkDefault [ "darkman" ];
  };
}
