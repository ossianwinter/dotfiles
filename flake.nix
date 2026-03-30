{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { nixpkgs, ... }:
    {
      nixosConfigurations.workstation = nixpkgs.lib.nixosSystem {
        modules = [
          ./machines/workstation
          ./nixos/1password.nix
          ./nixos/audio.nix
          ./nixos/darkman.nix
          ./nixos/email.nix
          ./nixos/firefox.nix
          ./nixos/fonts.nix
          ./nixos/git.nix
          ./nixos/gnome-keyring.nix
          ./nixos/steam.nix
          ./nixos/sway.nix
          ./users/ossian
          { users.users.ossian.extraGroups = [ "wheel" ]; }
        ];
      };
    };
}
