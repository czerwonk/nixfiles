{ config, pkgs, extraHomeModules, ... }:

{
  imports = [
    ../linux
    ../home-manager/presets/devops
  ] ++ extraHomeModules;
}
