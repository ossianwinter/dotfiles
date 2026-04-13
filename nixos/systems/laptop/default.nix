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
    cpu.intel.updateMicrocode = true;
    graphics = {
      enable = true;
      extraPackages = with pkgs; [ intel-media-driver vpl-gpu-rt ];
    };
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "kvm-intel" ];

    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };

    initrd = {
      kernelModules = [
        "nvme"
        "xhci_pci"
        "thunderbolt"
      ];

      luks.devices = {
        "luks-58ee0fdc-cc14-41cd-a0f6-a7ea70414404".device =
          "/dev/disk/by-uuid/58ee0fdc-cc14-41cd-a0f6-a7ea70414404";
      };
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/mapper/luks-58ee0fdc-cc14-41cd-a0f6-a7ea70414404";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/AC5B-2E02";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };
  };

  environment.pathsToLink = [ "/share/applications" "/share/xdg-desktop-portal" ];

  time.timeZone = "Europe/Stockholm";

  networking = {
    hostName = "laptop";
    networkmanager.enable = true;
  };

  programs = {
    dconf.enable = true;
    nix-ld.enable = true;
  };

  system.stateVersion = "25.11";
}
