{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ibm-plex
    symbola
  ];

  fonts.fontconfig = {
    enable = true;

    defaultFonts = {
      monospace = [
        "IBM Plex Mono"
        "Symbola"
      ];

      sansSerif = [
        "IBM Plex Sans"
        "Symbola"
      ];

      serif = [
        "IBM Plex Serif"
        "Symbola"
      ];
    };

    antialiasing = true;
    hinting = "none";
    subpixelRendering = "none";
  };
}
