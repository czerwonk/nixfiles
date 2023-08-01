{
  imports = [
    ./scripts
    ./suits/core
    ./suits/network
  ];
  
  home = {
    stateVersion = "23.05";
  };

  programs.home-manager.enable = true;
}
