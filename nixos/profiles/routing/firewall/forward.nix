{ lib, config, ... }:

{
  networking.firewall.filterForward = false;

  networking.nftables.tables."nixos-fw".content = lib.mkAfter ''
    chain forward {
      type filter hook forward priority filter; policy drop;
      ct status dnat accept comment "allow port forward"
      ct state vmap { established : accept, related : accept }
      icmpv6 type == { router-renumbering, 139 } jump drop-forward comment "Accept all ICMPv6 messages except renumbering and node information queries (type 139).  See RFC 4890, section 4.3."
      ${lib.flip lib.concatMapStrings config.networking.firewall.trustedInterfaces (iface: ''
        iifname "${iface}" accept
      '')}
      ip6 saddr 2001:678:1e0::/48 iifname @outside-interfaces counter drop comment "spoofed traffic"
      ip6 saddr 2001:678:1e0::/48 counter accept
      iifname @outside-interfaces ip saddr @bogon-v4 counter drop
      iifname @outside-interfaces ip6 saddr @bogon-v6 counter drop
      ${config.networking.firewall.extraForwardRules}
      ip6 saddr @blocklist-v6 counter drop
      ip6 daddr 2001:678:1e0::/48 counter accept
      counter jump drop-forward
    };

    chain drop-forward {
      tcp flags syn / fin,syn,rst,ack log prefix "refused forward: " level info
      drop
    }
  '';
}
