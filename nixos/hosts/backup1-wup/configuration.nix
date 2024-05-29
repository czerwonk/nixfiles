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
  #boot.zfs.extraPools = [ "zpool" ];

  networking = {
    hostId = "77889806";
    hostName = "backup1";
    domain = "wup.routing.rocks";
  };
}
