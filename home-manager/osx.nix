{ config, pkgs, username, ... }:

{
  imports = [
    ./default.nix
    ./presets/desktop
  ];
  
  home = {
    username = username;
    homeDirectory = "/Users/${username}";
  };
}
