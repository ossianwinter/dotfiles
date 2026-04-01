{ config, pkgs, ... }:
{
  programs.firefox.enable = true;

  home.packages = with pkgs; [ xdg-utils ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
    };
  };
}
