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
    ./subversion.nix
    ./sqitch.nix
    ./postgres.nix
  ];

  services = {
    mako.enable = true;

    wlsunset = {
      enable = true;
      latitude = 57.7;
      longitude = 11.9;
      temperature = {
        day = 4000;
        night = 3500;
      };
    };
  };

  programs = {
    bash.enable = true;

    codex.enable = true;

    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };

    discord = {
      enable = true;
      package =
        let
          discord = pkgs.discord.override { withKrisp = true; };
        in
        pkgs.symlinkJoin {
          name = "${discord.pname}-${discord.version}-epipe-fix";

          paths = [ discord ];

          nativeBuildInputs = [ pkgs.makeWrapper ];
          postBuild = ''
            rm -f "$out/bin/Discord" "$out/bin/discord"
            makeWrapper "${discord}/bin/Discord" "$out/bin/Discord" \
              --run 'exec >/dev/null 2>/dev/null'
            makeWrapper "${discord}/bin/discord" "$out/bin/discord" \
              --run 'exec >/dev/null 2>/dev/null'
          '';

          meta = discord.meta;
          passthru = discord.passthru or { };
        };
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
    entries = [ "${pkgs._1password-gui}/share/applications/1password.desktop" ];
  };

  home = {
    packages = with pkgs; [
      xdg-utils
      jetbrains.idea
      oama
      code-cursor
      devenv
    ];
    stateVersion = "25.11";
  };
}
