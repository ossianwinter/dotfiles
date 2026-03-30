{ ... }:
{
  accounts.email.accounts.personal = {
    primary = true;
    flavor = "fastmail.com";
    address = "ossian@winter.vg";
    realName = "Ossian Winter";
    userName = "ossian@fastmail.com";
    passwordCommand = "op read op://iadi64yxnoyh2b5xosdxiydcna/i7o5bqrpenxguh5psiaave5k7m/credential";

    mbsync = {
      enable = true;
      create = "both";
      remove = "both";
      expunge = "both";
    };

    msmtp.enable = true;

    mu.enable = true;
  };

  programs = {
    mbsync.enable = true;
    msmtp.enable = true;
    mu.enable = true;

    emacs.extraPackages = epkgs: [ epkgs.mu4e ];
  };
}
