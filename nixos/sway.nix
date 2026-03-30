{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = lib.mkDefault true;
  };

  # required by wlr portal
  services.pipewire.enable = true;

  # polkit is (mostly) useless without an agent
  systemd.user.services.polkit-gnome-authentication-agent-1 = lib.mkIf config.security.polkit.enable (lib.mkDefault {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  });
}
