{ config, lib, pkgs, ... }:

{
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
}
