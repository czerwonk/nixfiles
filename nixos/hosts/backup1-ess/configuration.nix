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

  networking = {
    hostId = "a4ca5dcd";
    hostName = "backup1";
    domain = "ess.routing.rocks";
    useNetworkd = true;
    useDHCP = true;
  };
  systemd.network.enable = false;
}
