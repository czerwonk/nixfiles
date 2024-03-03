{ lib, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ../../configuration.nix
    ../../profiles/server
    ../../profiles/webserver
    ../../profiles/container
    #./unifi.nix
    ../../zfs.nix
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

  networking.hostId = "76affc21";
  networking.useNetworkd = false;
  networking.useDHCP = false;
  systemd.network.enable = false;

  services.dnsmasq.settings.no-hosts = false;

  my.services.openssh-server.openFirewall = false;

  my.services.monitoring.enable = true;
  my.services.jellyfin.enable = true;
  my.services.nextcloud.enable = true;
  my.services.freshrss.enable = true;
  my.services.immich.enable = true;
  my.services.calibre-web.enable = true;
  my.services.audiobookshelf.enable = true;
  my.services.forgejo.enable = true;
  my.services.pihole.enable = true;

  my.services.netdata.receiver = true;
}
