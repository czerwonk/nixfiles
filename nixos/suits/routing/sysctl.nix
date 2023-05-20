{ ... }:

{
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = true;
    "net.ipv4.ip_nonlocal_bind" = true;
    "net.ipv4.conf.all.forwarding" = true;
    "net.ipv4.conf.default.forwarding" = true;
    "net.ipv4.tcp_low_latency" = true;
    "net.ipv4.route.max_size" = 2147483647;

    "net.ipv6.conf.all.forwarding" = true;
    "net.ipv6.conf.default.forwarding" = true;
    "net.ipv6.conf.all.autoconf" = false;
    "net.ipv6.conf.default.autoconf" = false;
    "net.ipv6.conf.default.accept_ra" = false;
    "net.ipv6.route.max_size" = 2147483647;

    "net.netfilter.nf_conntrack_max" = 120000;
    "net.netfilter.nf_conntrack_tcp_loose" = false;

    "net.core.netdev_max_backlog" = 10000;

    "vm.max_map_count" = 262144;
  };
}
