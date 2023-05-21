{ pkgs, routingRocks, ... }:

{
  imports = [ 
    (import routingRocks)
    ./hardware-configuration.nix
    ../../configuration.nix
    ../../suits/server
    ../../suits/container
    ../../suits/routing
  ];

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    useOSProber = true;
  };

  networking = {
    domain = "dus.routing.rocks";
    dhcpcd.enable = false;
    interfaces = {
      enp0s5.ipv4.addresses = [{
        address = "10.211.55.128";
        prefixLength = 24;
      }];
    };
    defaultGateway = "10.211.55.1";
  };
}
