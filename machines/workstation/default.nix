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

    initrd = {
      kernelModules = [
        "nvme"
        "xhci_pci"
      ];

      luks.devices = {
        "luks-6f885ba0-aeed-4d0b-af5d-63e993c5ba89".device =
          "/dev/disk/by-uuid/6f885ba0-aeed-4d0b-af5d-63e993c5ba89";
      };
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/mapper/luks-6f885ba0-aeed-4d0b-af5d-63e993c5ba89";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/D6A3-FE76";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };
  };

  time.timeZone = "Europe/Stockholm";

  networking = {
    hostName = "workstation";
    domain = "home.winter.vg";
  };

  system.stateVersion = "25.11";
}
