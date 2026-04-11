{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacsWithPackagesFromUsePackage {
      config = ./emacs/init.el;
      package = pkgs.emacs-pgtk;
      extraEmacsPackages = epkgs: [ epkgs.treesit-grammars.with-all-grammars ];
      override = final: prev: {
        auth-source-1password = prev.melpaPackages.auth-source-1password.overrideAttrs(old: {
          src = pkgs.fetchFromGitHub {
            owner = "ossianwinter";
            repo = "auth-source-1password";
            rev = "b13054ef429fbb357e0a9810e682e81cdd17c64b";
            hash = "sha256-9jdCVZ6ZwV+Jn8pFCBMj2iB+gtCMmpVKlZuYqYyOkcw=";
          };
        });

        auth-source-oama = prev.trivialBuild {
          pname = "auth-source-oama";
          version = "0.1.0";

          src = pkgs.fetchFromGitHub {
            owner = "ossianwinter";
            repo = "auth-source-oama";
            rev = "e9ca0b96a8a741fc95a9dfbc80fb8c063175c211";
            hash = "sha256-zU9cIvsPBnjtDjZWqUk61Yjfq3HRHBrhfchmvBoAV+o=";
          };
        };

        nov = prev.melpaPackages.nov.overrideAttrs(old: {
          packageRequires = old.packageRequires ++ [ pkgs.unzip ];
        });
      };
    };
  };

  xdg = {
    configFile."emacs" = {
      source = ./emacs;
      recursive = true;
    };

    portal = {
      extraPortals =
        let
          xdg-desktop-portal-emacs = pkgs.stdenv.mkDerivation {
            pname = "xdg-desktop-portal-emacs";
            version = pkgs.emacsPackages.filechooser.version;

            src = pkgs.emacsPackages.filechooser.src;

            installPhase = ''
              mkdir -p $out/share/dbus-1/services/
              cp org.gnu.Emacs.FileChooser.service $out/share/dbus-1/services/

              mkdir -p $out/share/xdg-desktop-portal/portals/
              cp emacs.portal $out/share/xdg-desktop-portal/portals/
            '';
          };
        in [ xdg-desktop-portal-emacs ];

      config = {
        common = {
          "org.freedesktop.impl.portal.FileChooser" = [ "emacs" ];
        };

        # TODO: Not sure why queries to the FileChooser portal don’t fall back to common,
        #       it’s strange since queries to the Settings portal do seem to fall back...
        sway = {
          "org.freedesktop.impl.portal.FileChooser" = [ "emacs" ];
        };
      };
    };
  };
}
