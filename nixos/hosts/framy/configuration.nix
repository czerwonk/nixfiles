{ pkgs, lib, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ../../configuration.nix
    ../../suits/desktop
    ../../suits/pentest
    ../../suits/container
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.extraModprobeConfig = ''
    options usbserial vendor=0403 product=6001
  '';

  boot.initrd.secrets = {
    "/persist/crypto_keyfile.bin" = null;
  };
  boot.initrd.postDeviceCommands = lib.mkBefore ''
    mkdir -p /btrfs_mnt
    mount -o subvol=/ /dev/mapper/enc /btrfs_mnt
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

  security.lockKernelModules = false;

  services.fwupd.enable = true;

  services.printing.enable = true;

  services.fprintd = {
    enable = true;
    tod = {
      enable = true;
      driver = pkgs.libfprint-2-tod1-goodix;
    };
  };

  suits.desktop.enablePowerManagement = true;
}
