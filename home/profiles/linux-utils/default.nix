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
      procs
      samba
      strace
      usbutils
    ];
  };
}
