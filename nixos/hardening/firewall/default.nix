{ lib, ... }:

{
  imports = [
    ./nftables.nix
  ];

  boot.kernelModules = [
    "nft_fib"
    "nft_fib_inet"
    "nft_fib_ipv4"
    "nft_fib_ipv6"
    "nft_log"
    "nft_limit"
    "nft_ct"
    "nft_nat"
    "xt_nat"
    "xt_connmark"
    "xt_mark"
    "xt_comment"
    "xt_limit"
    "xt_addrtype"
    "xt_multiport"
  ];

  networking.firewall.enable = true;
  networking.firewall.checkReversePath = false;
  networking.firewall.filterForward = lib.mkDefault true;

  networking.nftables.enable = lib.mkDefault true;
}
