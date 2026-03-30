{ pkgs, ... }:
{
  imports = [
    ./darkman.nix
    ./email.nix
  ];

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBATgOCSG5++OrEi+r/gcwo7oSUGKCKxVdGV87povcfO";
      format = "ssh";
      signByDefault = true;
      signer = "${pkgs._1password-gui}/bin/op-ssh-sign";
    };
    settings = {
      user = {
        name = "Ossian Winter";
        email = "ossian@winter.vg";
      };
    };
  };

  home.stateVersion = "25.11";
}
