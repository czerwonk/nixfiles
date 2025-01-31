{
  imports = [
    ./scripts
    ./profiles/core
    ./profiles/network
  ];

  nixpkgs.config.allowUnfree = true;

  home = {
    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;
}
