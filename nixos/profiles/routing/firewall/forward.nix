{ lib, config, ... }:

with lib;

{
  options = {
    my.networking.firewall.extraForwardRules = mkOption {
      type = types.lines;
      default = "";
      description = "Rules to insert in the forward chain before the drop policy hits";
    };
  };

  config = {
    networking.firewall.filterForward = false;

    networking.nftables.tables."nixos-fw".content = lib.mkAfter ''
      chain forward {
        type filter hook forward priority filter; policy drop;
        ct status dnat accept comment "allow port forward"
        ct state vmap { established : accept, related : accept }
        icmpv6 type == { router-renumbering, 139 } jump drop-forward comment "Accept all ICMPv6 messages except renumbering and node information queries (type 139).  See RFC 4890, section 4.3."
        iifname "lo" accept
        iifname "wg*" accept
        iifname "podman*" accept
        ${config.my.networking.firewall.extraForwardRules}
        ip6 saddr 2001:678:1e0::/48 counter accept
        ip6 saddr @blocklist-v6 counter drop
        ip6 daddr 2001:678:1e0::/48 counter accept
        counter jump drop-forward
      };

      chain drop-forward {
        tcp flags syn / fin,syn,rst,ack log prefix "refused forward: " level info
        drop
      }
    '';
  };
}
