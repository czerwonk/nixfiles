{ lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../configuration.nix
    ../../zfs
    ../../profiles/container
    ../../profiles/server
    ../../profiles/webserver
    ./home-assistant.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.blacklistedKernelModules = lib.mkForce [ "firewire-core" ];

  networking = {
    hostName = "home2";
    domain = "ess.routing.rocks";
    hostId = "3facf4b1";
    useNetworkd = false;
    useDHCP = false;
    firewall.filterForward = false;
  };
  systemd.network.enable = false;

  my.services.openssh-server.openFirewall = false;
  my.services.unifi.enable = true;
  my.services.nordvpn.enable = true;
}
