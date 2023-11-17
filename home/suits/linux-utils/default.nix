{ pkgs, ... }:

{
  home = {
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
      inotify-tools
      btrfs-progs
    ];
  };
}
