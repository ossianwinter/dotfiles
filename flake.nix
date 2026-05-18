{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-discord-krisp-patcher.url = "github:NixOS/nixpkgs/pull/506089/head";
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
    {
      nixpkgs,
      nixpkgs-discord-krisp-patcher,
      home-manager,
      emacs-overlay,
      ...
    }:
    let
      discord-krisp-patcher-overlay = (
        final: prev:
        let
          pkgs-discord-krisp-patcher = import nixpkgs-discord-krisp-patcher {
            system = final.stdenv.hostPlatform.system;
            config.allowUnfree = final.config.allowUnfree;
          };
        in
        {
          discord = pkgs-discord-krisp-patcher.discord;
        }
      );
    in
    {
      nixosConfigurations.workstation = nixpkgs.lib.nixosSystem {
        modules = [
          ./nixos/systems/workstation
          ./nixos/users/ossian
          { users.users.ossian.extraGroups = [ "wheel" ]; }

          ./nixos/1password.nix
          ./nixos/audio.nix
          ./nixos/steam.nix

          {
            nixpkgs.overlays = [
              emacs-overlay.overlay
              discord-krisp-patcher-overlay
            ];
          }

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
          {
            users.users.ossian.extraGroups = [
              "networkmanager"
              "wheel"
            ];
          }

          ./nixos/1password.nix
          ./nixos/audio.nix

          {
            nixpkgs.overlays = [
              emacs-overlay.overlay
              discord-krisp-patcher-overlay
            ];
          }

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
