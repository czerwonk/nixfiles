{
  boot.kernel.sysctl = {
    "vm.swappiness" = 1;
    "net.core.default_qdisc" = "fq";
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.ipv4.tcp_notsent_lowat" = 16384;

    "net.netfilter.nf_conntrack_max" = 120000;
    "net.netfilter.nf_conntrack_tcp_loose" = false;

    "net.core.netdev_max_backlog" = 10000;
  };
}
