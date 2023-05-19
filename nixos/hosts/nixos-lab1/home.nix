{ config, pkgs, extraHomeModules, lib, ... }:

{
  imports = [
    ../../../home/linux.nix
  ] ++ extraHomeModules;
}
