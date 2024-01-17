{
  boot.kernel.sysctl = {
    "vm.swappiness" = 1;
    "net.core.default_qdisc" = "fq";
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.ipv4.tcp_notsent_lowat" = 16384;
  };
}
