{ lib, config, ... }:

with lib;

{
  options = {
    my.networking.firewall.extraInputRules = mkOption {
      type = types.lines;
      default = "";
      description = "Rules to insert in the input-allow chain before the drop policy hits";
    };
  };

  config = {
    networking.firewall.extraInputRules = lib.mkAfter ''
      ${config.my.networking.firewall.extraInputRules}
      ip6 saddr 2001:678:1e0::/48 tcp dport 9100 accept comment "node-exporter"
      ip6 saddr 2001:678:1e0::/48 tcp dport 9324 accept comment "bird-exporter"
      ip6 saddr 2001:678:1e0::/48 tcp dport 9134 accept comment "zfs-exporter"
      ip6 saddr 2001:678:1e0::/48 udp dport 8888 accept comment "ethr"
      ip6 saddr 2001:678:1e0::/48 tcp dport 8888 accept comment "ethr"
      ip6 saddr 2001:678:1e0::/48 udp dport 5201 accept comment "iperf3"
      ip6 saddr 2001:678:1e0::/48 tcp dport 5201 accept comment "iperf3"
    '';
  };
}
