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
    ../../profiles/webserver
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.zfs.forceImportRoot = true;
  boot.initrd.postDeviceCommands = lib.mkAfter ''
    zfs rollback -r zroot/root@blank
  '';

  networking.hostId = "2d1165a8";

  my.services.matrix.enable = true;
  my.services.mastodon.enable = true;

  my.services.crowdsec.metricsListenAddr = "[${loopback.address}]";
}
