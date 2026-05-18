{ pkgs, ... }:
{
  home.packages = with pkgs; [ subversion ];

  home.file."subversion" = {
    enable = true;
    recursive = true;
    source = ./subversion;
    target = ".subversion";
  };
}
