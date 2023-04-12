{ pkgs, ... }:

{
  imports = [
    ./scripts
    ./presets/core
    ./presets/network
  ];
  
  programs.home-manager.enable = true;
}
