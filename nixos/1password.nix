{ config, lib, ... }:
{
  programs._1password.enable = lib.mkDefault true;
  programs._1password-gui.enable = lib.mkDefault true;

  # 1Password uses polkit for the (optional) system authentication service,
  security.polkit.enable = lib.mkIf config.programs._1password-gui.enable (lib.mkDefault true);
}
