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
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostId = "292ea3ce";
    hostName = "bb2";
    domain = "dus.routing.rocks";
  };

  virtualisation.containers.containersConf.settings.network.firewall_driver = "none";

  my.services.ripe-atlas.enable = true;

  my.services.crowdsec.metricsListenAddr = "[${loopback.address}]";
}
