{ lib, ... }:

{
  networking.nftables.tables."nixos-fw".content = lib.mkOrder 10 ''
    chain pre-input {
      type filter hook input priority filter - 1; policy accept;
      iifname @outside-interfaces jump filter-ingress
    }
  '';

  networking.firewall.extraInputRules = lib.mkAfter ''
    ip6 saddr 2001:678:1e0::/48 tcp dport 9100 accept comment "node-exporter"
    ip6 saddr 2001:678:1e0::/48 tcp dport 9324 accept comment "bird-exporter"
    ip6 saddr 2001:678:1e0::/48 tcp dport 9134 accept comment "zfs-exporter"
    ip6 saddr 2001:678:1e0::/48 udp dport 8888 accept comment "ethr"
    ip6 saddr 2001:678:1e0::/48 tcp dport 8888 accept comment "ethr"
    ip6 saddr 2001:678:1e0::/48 udp dport 5201 accept comment "iperf3"
    ip6 saddr 2001:678:1e0::/48 tcp dport 5201 accept comment "iperf3"
  '';
}
