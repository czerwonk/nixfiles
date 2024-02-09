{ lib, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ../../configuration.nix
    ../../suits/server
    ../../suits/webserver
    ../../suits/container
    ./unifi.nix
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

  networking.useNetworkd = false;
  networking.useDHCP = false;
  systemd.network.enable = false;

  services.dnsmasq.settings.no-hosts = false;

  services.custom.openssh-server.openFirewall = false;

  services.custom.monitoring.enable = true;
  services.custom.jellyfin.enable = true;
  services.custom.nextcloud.enable = true;
  services.custom.freshrss.enable = true;
  services.custom.immich.enable = true;
  services.custom.calibre-web.enable = true;
  services.custom.audiobookshelf.enable = true;
}
