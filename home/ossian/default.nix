{ pkgs, ... }:
{
  imports = [
    ./darkman.nix
    ./emacs.nix
    ./email.nix
    ./firefox.nix
    ./fonts.nix
    ./keyring.nix
    ./sway.nix
  ];

  services = {
    mako.enable = true;

    wlsunset = {
      enable = true;
      latitude = 57.7;
      longitude = 11.9;
      temperature = {
        day = 5000;
        night = 3500;
      };
    };
  };

  programs = {
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

    vesktop.enable = true;
  };

  xdg.autostart.entries = [
    "${pkgs._1password-gui}/share/applications/1password.desktop"
  ];

  home.stateVersion = "25.11";
}
