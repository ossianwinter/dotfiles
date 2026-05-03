{ pkgs, ... }:
{
  imports = [
    # ./chromium.nix
    ./darkman.nix
    ./emacs.nix
    ./email.nix
    ./firefox.nix
    ./fonts.nix
    ./keyring.nix
    ./oama.nix
    ./podman.nix
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
    bash.enable = true;

    claude-code.enable = true;
    codex.enable = true;

    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };

    discord = {
      enable = true;
      settings.SKIP_HOST_UPDATE = true;
    };

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

  xdg.autostart = {
    enable = true;
    entries = [
      "${pkgs._1password-gui}/share/applications/1password.desktop"
    ];
  };

  home = {
    packages = with pkgs; [ xdg-utils jetbrains.idea oama ];

    stateVersion = "25.11";
  };
}
