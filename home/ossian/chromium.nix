{ pkgs, ... }:
let
  extensions = [
    { id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa"; # 1Password
      version = "8.12.8.26";
      url = "https://clients2.googleusercontent.com/crx/blobs/AQx-wa4v6s8nfK4gNf3TzaoQCq_VUyxrGMnDq_L4wzV7dpuoBHUkTiylcfNHpz5yWhztOcceOh9RuZ7grLbaduokday2bdsFOtYNlK5vrkpoESUe3W6cCulQSI2e2PRuPVrMAMZSmuXuLiJzaOTfxN-uoNehZKGNduRRiQ/AEBLFDKHHHDCDJPIFHHBDIOJPLFJNCOA_8_12_8_26.crx";
      hash = "sha256-k1Y+5hiWmnb6l8BIepT+MveK8QK7qQGQCZREj0+mt1w=";
    }
    { id = "ddkjiahejlhfcafbddmgiahcphecmpfh"; # uBlock Lite
      version = "2026.329.1951";
      url = "https://clients2.googleusercontent.com/crx/blobs/AQx-wa46CPJFzgqSDy8Z8ejLu6cP1JdTKXjSXRFUjxSc3TznJQj4WBmcnpxoUMjsiormmbOs8cBnq1H_PsYiPFS-F9MZUa5guySFamxBgAxO9Vbji4c92cQu6k36sK4UolcuAMZSmuU-ZhSAIt7dfxaWOYHeiwEsZCcXbQ/DDKJIAHEJLHFCAFBDDMGIAHCPHECMPFH_2026_329_1951_0.crx";
      hash = "sha256-mwq2ydJZmcihBR9ClYvbsOC54NDPh+I6tMd2pkXtHV4=";
    }
  ];
  mkExtension = { id, version, url, hash }: {
    inherit id version;
    crxPath = pkgs.fetchurl {
      inherit url hash;
      name = "${id}.crx";
    };
  };
in
{
  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
    extensions = map mkExtension extensions;
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = [ "chromium-browser.desktop" ];
      "x-scheme-handler/http" = [ "chromium-browser.desktop" ];
      "x-scheme-handler/https" = [ "chromium-browser.desktop" ];
    };
  };
}
