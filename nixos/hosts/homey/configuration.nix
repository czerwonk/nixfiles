{ lib, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ../../configuration.nix
    ../../zfs.nix
    ../../profiles/server
    ../../profiles/webserver
    ../../profiles/container
    ./unifi.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.zfs.forceImportRoot = true;
  boot.zfs.requestEncryptionCredentials = [ "zroot" "zpool" ];

  boot.initrd.postDeviceCommands = lib.mkAfter ''
    zfs rollback -r zroot/root@blank
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
  my.services.adguard.enable = true;
  my.services.ntfy.enable = true;

  my.services.netdata.receiver = true;
}
