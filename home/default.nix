{ ... }:

{
  imports = [
    ./scripts
    ./suits/core
    ./suits/network
  ];
  
  home = {
    stateVersion = "22.11";
  };

  programs.home-manager.enable = true;
}
