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
        nov = prev.melpaPackages.nov.overrideAttrs(old: {
          packageRequires = old.packageRequires ++ [ pkgs.unzip ];
        });
      };
    };
  };

  xdg.configFile."emacs" = {
    source = ./emacs;
    recursive = true;
  };
}
