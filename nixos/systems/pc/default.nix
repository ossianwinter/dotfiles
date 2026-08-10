{ pkgs, ... }:
{
  nixpkgs = {
    hostPlatform = "x86_64-linux";
    config.allowUnfree = true;
  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  hardware = {
    enableRedistributableFirmware = true;
    cpu.amd.updateMicrocode = true;
    graphics.enable = true;
    amdgpu.initrd.enable = true;
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "kvm-amd" ];

    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };

    initrd.kernelModules = [
      "nvme"
      "xhci_pci"
    ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/52e9dd2a-b047-4c2e-9a67-02a92308b32d";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/EF5B-6A04";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };
  };

  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
  ];

  time.timeZone = "Europe/Stockholm";

  networking = {
    hostName = "pc";
    domain = "home.winter.vg";
  };

  services.udisks2.enable = true;

  programs = {
    dconf.enable = true;
    nix-ld.enable = true;
  };

  system.stateVersion = "25.11";
}
