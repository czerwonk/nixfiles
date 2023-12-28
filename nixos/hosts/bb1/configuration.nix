{ lib, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ../../configuration.nix
    ../../suits/server
    ../../suits/container
    ../../suits/routing
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.postDeviceCommands = lib.mkAfter ''
    mkdir -p /mnt
    mount -o subvol=/ /dev/disk/by-uuid/36b9d213-1c1d-4398-98be-b27eb53dae60 /mnt
    echo "Delete old root subvolume..."
    btrfs subvolume list -o /mnt/root |
      cut -f 9 -d ' ' |
      while read subvolume; do
        echo "Delete subvolume $subvolume..."
        btrfs subvolume delete "/mnt/$subvolume"
      done
    btrfs subvolume delete /mnt/root
    echo "Create new root subvolume..."
    btrfs subvolume create /mnt/root
    umount /mnt
  '';
}
