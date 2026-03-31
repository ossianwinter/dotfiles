{ config, pkgs, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    systemd.xdgAutostart = true;
    wrapperFeatures.gtk = true;
    config = {
      fonts = {
        names = config.fonts.fontconfig.defaultFonts.monospace;
        size = 12.0;
      };
      focus.followMouse = "no";
      modifier = "Mod4";
      menu = "${pkgs.wmenu}/bin/wmenu-run | ${pkgs.findutils}/bin/xargs swaymsg exec --";
      bars = [{
        statusCommand = "${pkgs.i3status}/bin/i3status";
        fonts = {
          names = config.fonts.fontconfig.defaultFonts.sansSerif;
          size = 12.0;
        };
      }];
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk xdg-desktop-portal-wlr ];
    config.sway = {
      default = [ "gtk" ];
      "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
      "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
    };
  };

  # polkit is (mostly) useless without an agent
  services.polkit-gnome.enable = true;
}
