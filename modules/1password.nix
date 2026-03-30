{ config, lib, ... }:
let
  graphical = config.services.graphical-desktop.enable;
in
{
  programs._1password.enable = true;
  programs._1password-gui.enable = lib.mkIf graphical true;

  # 1Password uses polkit for the (optional) system authentication service,
  security.polkit.enable = lib.mkIf graphical true;

  programs.git.config = lib.mkIf graphical {
    gpg.ssh.program = "${config.programs._1password-gui.package}/bin/op-ssh-sign";
  };
}
