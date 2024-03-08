{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      bcachefs-tools
      btop
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
