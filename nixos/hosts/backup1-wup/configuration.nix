{ lib, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ../../configuration.nix
    ../../zfs.nix
    ../../profiles/server
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.zfs.forceImportRoot = true;
  boot.zfs.requestEncryptionCredentials = [ "zroot" "zpool" ];
  boot.zfs.extraPools = [ "zpool" ];

  boot.initrd.postDeviceCommands = lib.mkAfter ''
    zfs rollback -r zroot/root@blank
  '';

  networking = {
    hostId = "c1be8f9f";
    hostName = "backup1";
    domain = "wup.routing.rocks";
  };
}
