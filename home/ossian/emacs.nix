{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    extraPackages = epkgs: [ epkgs.vterm ];
  };

  xdg.configFile."emacs" = {
    source = ./emacs;
    recursive = true;
  };
}
