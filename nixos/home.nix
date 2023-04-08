{ config, pkgs, extraHomeModules, ... }:

{
  imports = [
    ../linux/home.nix
    ../home/devops
    ../home/profiles/default
  ] ++ extraHomeModules;
}
