{ config, ... }:

{
  imports = [
    ../common.nix
  ];

  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;

  networking.firewall.enable = true;
  networking.nftables.enable = true;

  my.services.openssh-server = {
    enable = true;
    openFirewall = true;
  };
}
