{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, emacs-overlay, ... }:
    {
      nixosConfigurations.workstation = nixpkgs.lib.nixosSystem {
        modules = [
          ./nixos/systems/workstation
          ./nixos/users/ossian
          { users.users.ossian.extraGroups = [ "wheel" ]; }

          ./nixos/1password.nix
          ./nixos/audio.nix
          ./nixos/steam.nix

          { nixpkgs.overlays = [ emacs-overlay.overlay ]; }

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.ossian = ./home/ossian;
            };
          }
        ];
      };

      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        modules = [
          ./nixos/systems/laptop
          ./nixos/users/ossian
          { users.users.ossian.extraGroups = [ "networkmanager" "wheel" ]; }

          ./nixos/1password.nix
          ./nixos/audio.nix

          { nixpkgs.overlays = [ emacs-overlay.overlay ]; }

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.ossian = ./home/ossian;
            };
          }
        ];
      };
    };
}
