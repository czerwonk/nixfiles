{ config, pkgs, username, ... }:

{
  imports = [
    ./default.nix
    ./suits/desktop
  ];
  
  home = {
    username = username;
    homeDirectory = "/Users/${username}";
    packages = with pkgs; [
      qemu
    ];
  };
}
