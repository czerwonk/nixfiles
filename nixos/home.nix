{ config, pkgs, extraHomeModules, ... }:

{
  imports = [
    ../linux
    ../home-manager/presets/devops
    ../home-manager/profiles/default
  ] ++ extraHomeModules;
}
