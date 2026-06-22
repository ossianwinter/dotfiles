{ pkgs, ... }:
{
  home.file.".sqitch" = {
    enable = true;
    recursive = true;
    source = ./sqitch;
    target = ".sqitch";
  };
}
