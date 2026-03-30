{ config, lib, ... }:
{
  programs._1password.enable = true;
  programs._1password-gui.enable = lib.mkIf config.services.graphical-desktop.enable (
    lib.mkDefault true
  );

  # 1Password uses polkit for the (optional) system authentication service,
  security.polkit.enable = lib.mkIf config.programs._1password-gui.enable (lib.mkDefault true);

  programs.git.config = lib.mkIf config.programs._1password-gui.enable {
    gpg.ssh.program = lib.mkDefault "${config.programs._1password-gui.package}/bin/op-ssh-sign";
  };
}
