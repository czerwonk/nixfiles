{ config, ... }:

let
  loopback = builtins.elemAt config.networking.interfaces.lo.ipv6.addresses 0;

in {
  imports = [ 
    ./hardware-configuration.nix
    ../../configuration.nix
    ../../zfs/kernel_6_6.nix
    ../../profiles/server
    ../../profiles/container
    ../../profiles/routing
    ../../profiles/webserver
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostId = "2d1165a8";
    hostName = "bb1";
    domain = "dus.routing.rocks";
  };

  my.services.matrix.enable = true;
  my.services.mastodon.enable = true;

  my.services.crowdsec.metricsListenAddr = "[${loopback.address}]";
}
