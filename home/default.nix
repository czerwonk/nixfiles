{
  imports = [
    ./scripts
    ./suits/core
    ./suits/network
  ];
  
  home = {
    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;
}
