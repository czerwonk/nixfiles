{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      btrfs-progs
      bubblewrap
      cifs-utils
      cryptsetup
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
      uutils-coreutils-noprefix
    ];
  };
}
