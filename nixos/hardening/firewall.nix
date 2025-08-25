{ lib, ... }:

{
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
  networking.firewall.allowPing = false;
  networking.firewall.extraInputRules = lib.mkOrder 0 ''
    icmp type != { timestamp-request, timestamp-reply } accept
  '';

  networking.nftables.enable = lib.mkDefault true;

  networking.nftables.tables."nixos-fw".content = lib.mkOrder 0 ''
    set blocklist-v4 {
      type ipv4_addr
      flags timeout
    }

    set blocklist-v6 {
      type ipv6_addr
      flags timeout
    }

    chain input-blocklist {
      type filter hook input priority filter - 1; policy accept;
      ip6 saddr 2001:678:1e0::/48 accept
      ip saddr @blocklist-v4 counter drop
      ip6 saddr @blocklist-v6 counter drop
    }
  '';
}
