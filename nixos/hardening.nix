{ pkgs, config, lib, ... }:

{
  users.mutableUsers = false;

  nix.settings.allowed-users = [ "@users" ];
  nix.settings.sandbox = lib.mkDefault false;

  boot.kernelPackages = pkgs.linuxPackages_hardened;

  security.protectKernelImage = true;
  security.forcePageTableIsolation = true;
  security.lockKernelModules = true;
  security.sudo.execWheelOnly = true;
  security.allowUserNamespaces = lib.mkDefault false;

  systemd.coredump.enable = lib.mkDefault false;

  boot.blacklistedKernelModules = [
    "ax25"
    "netrom"
    "rose"
    "dccp"
    "sctp"
    "rds"
    "tipc"

    # Old or rare or insufficiently audited filesystems
    "adfs"
    "affs"
    "bfs"
    "befs"
    "cramfs"
    "efs"
    "erofs"
    "exofs"
    "freevxfs"
    "f2fs"
    "hfs"
    "hpfs"
    "jfs"
    "minix"
    "nilfs2"
    "ntfs"
    "omfs"
    "qnx4"
    "qnx6"
    "sysv"
    "ufs"
  ];

  boot.kernel.sysctl = {
    "fs.protected_hardlinks" = true;
    "fs.protected_symlinks" = true;
    "fs.suid_dumpable" = false;

    "kernel.ctrl-alt-del" = false;
    "kernel.core_uses_pid" = true;
    "kernel.dmesg_restrict" = true;
    "kernel.kptr_restrict" = 2;
    "kernel.randomize_va_space" = 2;
    "kernel.sysrq" = false;
    "kernel.yama.ptrace_scope" = true;

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

    "net.ipv6.conf.all.accept_redirects" = false;
    "net.ipv6.conf.all.accept_source_route" = false;
    "net.ipv6.conf.default.accept_redirects" = false;
    "net.ipv6.conf.default.accept_source_route" = false;
  };

  networking.firewall.enable = true;
  networking.firewall.checkReversePath = "loose";

  security.apparmor.enable = true;
  security.apparmor.killUnconfinedConfinables = true;

  security.unprivilegedUsernsClone = config.virtualisation.containers.enable;
  security.virtualisation.flushL1DataCache = "always"; 

  services.fail2ban.enable = true;

  services.clamav = {
    updater.enable = true;
  };

  services.sysstat.enable = true;

  security.audit = {
    enable = true;
    rules = [
      "-a exit,always -F arch=b64 -F euid=0 -S execve"
    ];
  };
  security.auditd.enable = true;

  security.rtkit.enable = true;
  environment.systemPackages = with pkgs; [
    chkrootkit
    aide
    libpwquality
    acct
  ];
}
