{ config, ... }:

let
  loopback = builtins.elemAt config.networking.interfaces.lo.ipv6.addresses 0;

in
{
  imports = [
    ./hardware-configuration.nix
    ../../configuration.nix
    ../../zfs
    ../../profiles/server
    ../../profiles/container
    ../../profiles/routing
    ../../profiles/webserver
    ./hakanai.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostId = "2d1165a8";
    hostName = "bb1";
    domain = "dus.routing.rocks";
  };

  virtualisation.containers.containersConf.settings.network.firewall_driver = "none";

  my.services.alloy.enable = true;
  my.services.forgejo.enable = true;
  my.services.k3s.enable = true;
  my.services.mastodon.enable = true;
  my.services.matrix.enable = true;
  my.services.vaultwarden.enable = true;
  my.services.freshrss.enable = true;
  my.services.ntfy.enable = true;

  my.services.crowdsec.metricsListenAddr = "[${loopback.address}]";

}
