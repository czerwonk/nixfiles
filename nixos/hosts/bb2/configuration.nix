{ lib, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ../../configuration.nix
    ../../profiles/server
    ../../profiles/container
    ../../profiles/routing
    ../../zfs.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.zfs.forceImportRoot = true;
  boot.initrd.postDeviceCommands = lib.mkAfter ''
    zfs rollback -r zroot/root@blank
  '';

  networking.hostId = "292ea3ce";
}
