{ pkgs, ... }:
{
  users.users.ossian = {
    isNormalUser = true;
    description = "Ossian Winter";
  };

  programs._1password-gui.polkitPolicyOwners = [ "ossian" ];
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id == "com.1password.1Password.unlock" && subject.user == "ossian" && subject.local) {
        return "yes";
      }
    });
  '';
}
