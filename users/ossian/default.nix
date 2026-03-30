{ pkgs, ... }:
let
  myEmacs = (
    (pkgs.emacsPackagesFor pkgs.emacs-pgtk).emacsWithPackages (epkgs: [
      epkgs.mu4e
      epkgs.vterm
    ])
  );
in
{
  users.users.ossian = {
    isNormalUser = true;
    description = "Ossian Winter";
    packages = with pkgs; [
      chezmoi
      alacritty
      myEmacs
      jetbrains.idea
      claude-code
      codex
    ];
  };

  programs._1password-gui.polkitPolicyOwners = [ "ossian" ];
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id == "com.1password.1Password.unlock" && subject.user == "ossian" && subject.local) {
        return "yes";
      }
    });
  '';

  # Required for darkman scripts
  programs.dconf.enable = true;
}
