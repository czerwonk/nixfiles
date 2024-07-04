{ lib, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ../../configuration.nix
    ../../zfs.nix
    ../../profiles/server
    ../../profiles/webserver
    ./home-assistant.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.zfs.forceImportRoot = true;

  boot.blacklistedKernelModules = lib.mkForce [ "firewire-core" ];

  networking = {
    hostName = "home2";
    domain = "ess.routing.rocks";
    hostId = "3facf4b1";
    useNetworkd = false;
    useDHCP = false;
  };
  systemd.network.enable = false;

  my.services.openssh-server.openFirewall = false;
}
