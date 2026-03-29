{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ darkman ];

  xdg.portal.enable = true;
  xdg.portal.config.common = {
    "org.freedesktop.impl.portal.Settings" = [ "darkman" ];
  };
}
