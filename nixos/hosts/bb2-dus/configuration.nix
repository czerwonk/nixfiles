{ lib, config, ... }:

let
  loopback = builtins.elemAt config.networking.interfaces.lo.ipv6.addresses 0;

in {
  imports = [ 
    ./hardware-configuration.nix
    ../../configuration.nix
    ../../zfs
    ../../profiles/server
    ../../profiles/container
    ../../profiles/routing
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostId = "292ea3ce";
    hostName = "bb2";
    domain = "dus.routing.rocks";
  };

  my.services.crowdsec.metricsListenAddr = "[${loopback.address}]";
  my.services.ripe-atlas.enable = true;

  profiles.container.disableFirewall = true;
}
