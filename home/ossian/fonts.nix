{ pkgs, ... }:
{
  home.packages = with pkgs; [
    julia-mono
    ibm-plex
    symbola
  ];

  fonts.fontconfig = {
    enable = true;

    defaultFonts = {
      monospace = [ "JuliaMono" ];

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
