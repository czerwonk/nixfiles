{ pkgs, ... }:

{
  imports = [
    ./scripts
    ./presets/core
    ./presets/network
  ];
  
  home = {
    stateVersion = "22.11";
  };

  programs.home-manager.enable = true;
}
