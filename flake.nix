{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-discord-krisp-patcher.url = "github:NixOS/nixpkgs/pull/506089/head";
    nixpkgs-bitwig-5_19.url = "github:NixOS/nixpkgs/4154834be5af054e54afdb225e10d4c7bc37a255";
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
      nixpkgs-bitwig-5_19,
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
      bitwig-5_19-overlay = (
        final: prev:
        let
          pkgs-bitwig-5_19 = import nixpkgs-bitwig-5_19 {
            system = final.stdenv.hostPlatform.system;
            config.allowUnfree = final.config.allowUnfree;
          };
        in
        {
          bitwig-studio = pkgs-bitwig-5_19.bitwig-studio;
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
              bitwig-5_19-overlay
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
              bitwig-5_19-overlay
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
