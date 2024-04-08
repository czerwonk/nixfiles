{ lib, config, ... }:

let
  loopback = builtins.elemAt config.networking.interfaces.lo.ipv6.addresses 0;

in {
  imports = [ 
    ./hardware-configuration.nix
    ../../configuration.nix
    ../../zfs.nix
    ../../profiles/server
    ../../profiles/container
    ../../profiles/routing
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.zfs.forceImportRoot = true;
  boot.initrd.postDeviceCommands = lib.mkAfter ''
    zfs rollback -r zroot/root@blank
  '';

  networking = {
    hostId = "292ea3ce";
    hostName = "bb2";
    domain = "dus.routing.rocks";
  };

  my.services.crowdsec.metricsListenAddr = "[${loopback.address}]";
  my.services.ripe-atlas.enable = true;

  profiles.container.disableFirewall = true;
}
