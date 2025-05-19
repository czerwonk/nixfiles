{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      bcachefs-tools
      bottom
      btrfs-progs
      bubblewrap
      cifs-utils
      iftop
      inotify-tools
      iotop
      iputils
      parted
      pciutils
      procs
      samba
      strace
      traceroute
      usbutils
    ];
  };
}
