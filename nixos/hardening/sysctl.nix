{
  boot.kernel.sysctl = {
    "fs.protected_hardlinks" = true;
    "fs.protected_symlinks" = true;
    "fs.protected_fifos" = 2;
    "fs.protected_regular" = 2;
    "fs.suid_dumpable" = false;

    "kernel.ctrl-alt-del" = false;
    "kernel.core_uses_pid" = true;
    "kernel.dmesg_restrict" = true;
    "kernel.kptr_restrict" = 2;
    "kernel.randomize_va_space" = 2;
    "kernel.sysrq" = false;
    "kernel.yama.ptrace_scope" = true;
    "kernel.unprivileged_bpf_disabled" = true;

    "net.core.bpf_jit_harden" = 2;

    "net.ipv4.conf.all.accept_redirects" = false;
    "net.ipv4.conf.all.send_redirects" = false;
    "net.ipv4.conf.all.accept_source_route" = false;
    "net.ipv4.conf.all.bootp_relay" = false;
    "net.ipv4.conf.all.log_martians" = true;
    "net.ipv4.conf.all.rp_filter" = 2;
    "net.ipv4.conf.all.mc_forwarding" = false;
    "net.ipv4.conf.all.proxy_arp" = false;
    "net.ipv4.conf.default.accept_redirects" = false;
    "net.ipv4.conf.default.send_redirects" = false;
    "net.ipv4.conf.default.accept_source_route" = false;
    "net.ipv4.conf.default.log_martians" = true;
    "net.ipv4.conf.default.rp_filter" = 2;
    "net.ipv4.icmp_echo_ignore_broadcasts" = true;
    "net.ipv4.icmp_ignore_bogus_error_responses" = false;
    "net.ipv4.tcp_syncookies" = true;
    "net.ipv4.tcp_timestamps" = true;
    "net.ipv4.tcp_rfc1337" = true;

    "net.ipv6.conf.all.accept_redirects" = false;
    "net.ipv6.conf.all.accept_source_route" = false;
    "net.ipv6.conf.default.accept_redirects" = false;
    "net.ipv6.conf.default.accept_source_route" = false;
  };
}
