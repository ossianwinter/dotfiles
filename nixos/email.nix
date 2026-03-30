{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    isync
    mu
  ];

  programs.msmtp.enable = true;
}
