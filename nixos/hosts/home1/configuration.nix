{ lib, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ../../configuration.nix
    ../../zfs
    ../../profiles/server
    ../../profiles/webserver
    ../../profiles/container
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.zfs.requestEncryptionCredentials = [ "zroot" ];
  boot.zfs.extraPools = [ "zext" ];

  boot.blacklistedKernelModules = lib.mkForce [ "firewire-core" ];

  networking = {
    hostName = "home1";
    domain = "ess.routing.rocks";
    hostId = "76affc21";
    useNetworkd = false;
    useDHCP = false;
  };
  systemd.network.enable = false;

  services.dnsmasq.settings.no-hosts = false;

  my.services.openssh-server.openFirewall = false;

  my.services.audiobookshelf.enable = true;
  my.services.calibre-web.enable = true;
  my.services.forgejo.enable = true;
  my.services.freshrss.enable = true;
  my.services.immich.enable = true;
  my.services.jellyfin.enable = true;
  my.services.monitoring.enable = true;
  my.services.nextcloud.enable = true;
  my.services.ntfy.enable = true;
  my.services.vaultwarden.enable = true;
}
