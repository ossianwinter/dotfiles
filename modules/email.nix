{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    isync
    mu
  ];

  programs.msmtp.enable = true;

  systemd.user = {
    services.mbsync = {
      description = "mbsync";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.isync}/bin/mbsync --all";
      };
      unitConfig = {
        OnSuccess = [ "mu-index.service" ];
      };
    };

    services.mu-index = {
      description = "mu index";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.mu}/bin/mu index";
      };
    };

    timers.mbsync = {
      description = "mbsync";
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "*:0/5";
        Unit = "mbsync.service";
      };
    };
  };
}
