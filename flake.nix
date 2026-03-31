{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    {
      nixosConfigurations.workstation = nixpkgs.lib.nixosSystem {
        modules = [
          ./nixos/systems/workstation
          ./nixos/users/ossian
          { users.users.ossian.extraGroups = [ "wheel" ]; }

          ./nixos/1password.nix
          ./nixos/audio.nix
          ./nixos/steam.nix

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
