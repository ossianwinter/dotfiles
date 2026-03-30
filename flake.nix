{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { nixpkgs, ... }:
    {
      nixosConfigurations.workstation = nixpkgs.lib.nixosSystem {
        modules = [
          ./machines/workstation
          ./modules/1password.nix
          ./modules/audio.nix
          ./modules/darkman.nix
          ./modules/email.nix
          ./modules/firefox.nix
          ./modules/fonts.nix
          ./modules/git.nix
          ./modules/gnome-keyring.nix
          ./modules/steam.nix
          ./modules/sway.nix
          ./users/ossian
          { users.users.ossian.extraGroups = [ "wheel" ]; }
        ];
      };
    };
}
