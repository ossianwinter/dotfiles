{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ibm-plex
    symbola
    julia-mono
  ];

  fonts.fontconfig = {
    enable = true;

    defaultFonts = {
      monospace = [
        "IBM Plex Mono"
        "JuliaMono"
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
