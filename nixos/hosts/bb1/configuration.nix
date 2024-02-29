{ lib, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ../../configuration.nix
    ../../profiles/server
    ../../profiles/container
    ../../profiles/routing
    ../../profiles/webserver
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.postDeviceCommands = lib.mkAfter ''
    mkdir -p /btrfs_mnt
    mount -o subvol=/ /dev/md127 /btrfs_mnt
    echo "Delete old root subvolume..."
    btrfs subvolume list -o /btrfs_mnt/root |
      cut -f 9 -d ' ' |
      while read subvolume; do
        echo "Delete subvolume $subvolume..."
        btrfs subvolume delete "/btrfs_mnt/$subvolume"
      done
    btrfs subvolume delete /btrfs_mnt/root
    echo "Create new root subvolume..."
    btrfs subvolume create /btrfs_mnt/root
    umount /btrfs_mnt
  '';

  networking.hostId = "2d1165a8";

  my.services.matrix.enable = true;
  my.services.mastodon.enable = true;
  my.services.ripe-atlas.enable = true;
}
