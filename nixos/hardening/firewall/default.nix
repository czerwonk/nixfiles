{ lib, ... }:

{
  imports = [
    ./nftables.nix
    ./iptables.nix
  ];

  networking.firewall.enable = true;
  networking.firewall.checkReversePath = false;
  networking.firewall.filterForward = lib.mkDefault true;

  networking.nftables.enable = lib.mkDefault true;
}
