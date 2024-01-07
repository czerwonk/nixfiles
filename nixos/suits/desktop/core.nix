{ lib, ... }:

{
  security.allowUserNamespaces = true;
  nix.settings.sandbox = true;

  boot.kernelParams = [ "panic=0" ];

  networking.useDHCP = lib.mkDefault true;
  networking.networkmanager.enable = true;
  networking.nftables.enable = true;
  networking.firewall.filterForward = true;
}
