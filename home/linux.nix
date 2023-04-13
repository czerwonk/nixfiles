{ config, pkgs, username, ... }:

{
  imports = [
    ./default.nix
    ./presets/linux-utils
  ];
  
  home = {
    username = username;
    homeDirectory = if username == "root" then "/root" else "/home/${username}";
  };
}
