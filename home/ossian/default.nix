{ pkgs, ... }:
{
  imports = [
    ./darkman.nix
    ./emacs.nix
    ./email.nix
    ./fonts.nix
    ./keyring.nix
    ./sway.nix
  ];

  services.wlsunset = {
    enable = true;
    latitude = 57.7;
    longitude = 11.9;
    temperature = {
      day = 5000;
      night = 4000;
    };
  };

  programs = {
    firefox.enable = true;

    git = {
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
  };

  home.stateVersion = "25.11";
}
