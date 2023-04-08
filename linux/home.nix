{ config, pkgs, username, ... }:

{
  imports = [
    ../home/base/home.nix
  ];
  
  home = {
    username = username;
    homeDirectory = if username == "root" then "/root" else "/home/${username}";
    stateVersion = "22.11";

    packages = with pkgs; [ 
      strace
      iftop
      iotop
      atop
      cifs-utils
      zmap
      samba
      pciutils
      usbutils
    ];
  };

  programs.home-manager.enable = true;
}
