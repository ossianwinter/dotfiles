{ pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = false;
    packages = with pkgs; [
      ibm-plex
      symbola
      julia-mono
    ];

    fontconfig.defaultFonts = {
      serif = [
        "IBM Plex Serif"
        "Symbola"
      ];
      sansSerif = [
        "IBM Plex Sans"
        "Symbola"
      ];
      monospace = [
        "IBM Plex Mono"
        "JuliaMono"
      ];
    };
  };
}
