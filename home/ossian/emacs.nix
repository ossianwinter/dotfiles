{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacsWithPackagesFromUsePackage {
      config = ./emacs/init.el;
      package = pkgs.emacs-pgtk;
    };
  };

  xdg.configFile."emacs" = {
    source = ./emacs;
    recursive = true;
  };
}
