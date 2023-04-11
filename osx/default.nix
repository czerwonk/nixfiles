{ config, pkgs, username, ... }:

{
  imports = [
    ../home-manager
  ];
  
  home = {
    username = username;
    homeDirectory = "/Users/${username}";
    stateVersion = "22.11";
    packages = with pkgs; [
      qemu 
    ];
  };

  programs.home-manager.enable = true;
}
