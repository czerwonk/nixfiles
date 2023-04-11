{ config, pkgs, extraHomeModules, ... }:

{
  imports = [
    ../linux
    ../home-manager/presets/devops
    ../home/profiles/default
  ] ++ extraHomeModules;
}
