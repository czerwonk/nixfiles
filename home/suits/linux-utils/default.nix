{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      atop
      bcachefs-tools
      btrfs-progs
      cifs-utils
      iftop
      inotify-tools
      iotop
      parted
      pciutils
      samba
      strace
      usbutils
      zmap
    ];
  };
}
