{ pkgs, ... }:
{
  programs.git.enable = true;
  programs.git.package = pkgs.gitFull;
}
