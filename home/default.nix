{
  imports = [
    ./scripts
    ./profiles/core
    ./profiles/network
  ];

  home = {
    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;
}
