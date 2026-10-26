{
  config,
  lib,
  pkgs,
  ...
}:

let
  user = "-F auid>=1000 -F auid!=unset";

  # sudo writes its own I/O logs constantly; drop those writes so the
  # file_integrity watch below only reports reads and foreign writes.
  # On NixOS the setuid wrapper execs the real store binary, so exe matches.
  sudoIoExclude = lib.optionalString config.security.sudo.enable "-a never,exit -F arch=b64 -F dir=/var/log/sudo-io -F perm=w -F exe=${config.security.sudo.package}/bin/sudo";

  rules = pkgs.writeText "audit.rules" ''
    -D
    -i

    # Drop CWD records (saves volume; relative paths in PATH records lose context)
    -a always,exclude -F msgtype=CWD

    ## NOTE: on the exit list the FIRST matching rule wins and sets the key.
    ## Order: watches -> failures -> broad syscall rules -> catch-alls.

    # --- file integrity --------------------------------------------------------
    # Many of these are symlinks into /etc/static on NixOS; watching them still
    # detects the link being replaced (tampering). Real files: passwd, group,
    # shadow, sudoers (mode 0440 -> copied, not linked).
    ${sudoIoExclude}
    -w /etc/passwd -p wa -k file_integrity
    -w /etc/group -p wa -k file_integrity
    -w /etc/shadow -p wa -k file_integrity
    -w /etc/sudoers -p wa -k file_integrity
    -w /etc/sysctl.d -p wa -k file_integrity
    -w /etc/login.defs -p wa -k file_integrity
    -w /etc/hosts -p wa -k file_integrity
    -w /etc/pam.d -p wa -k file_integrity
    -w /etc/ssh/sshd_config -p wa -k file_integrity
    -w /etc/localtime -p wa -k file_integrity
    -w /var/log/sudo-io -p wra -k file_integrity

    # NixOS generation switches (also catches per-user profile changes)
    -w /nix/var/nix/profiles -p wa -k system_profile

    # --- systemd ---------------------------------------------------------------
    # Real store binary, not the /run/current-system symlink (which never fires).
    -w ${config.systemd.package}/bin/systemctl -p x -k systemd
    -w /etc/systemd -p wa -k systemd

    # --- failed file creation --------------------------------------------------
    -a always,exit -F arch=b64 -S creat,mkdir,mkdirat,link,linkat,symlink,symlinkat,mknod,mknodat -F exit=-EACCES ${user} -k failed_file_create
    -a always,exit -F arch=b64 -S creat,mkdir,mkdirat,link,linkat,symlink,symlinkat,mknod,mknodat -F exit=-EPERM ${user} -k failed_file_create

    # --- failed file access ----------------------------------------------------
    -a always,exit -F arch=b64 -S open,openat,openat2,open_by_handle_at -F exit=-EACCES ${user} -k failed_file_access
    -a always,exit -F arch=b64 -S open,openat,openat2,open_by_handle_at -F exit=-EPERM ${user} -k failed_file_access

    # --- failed file modifications (incl. failed deletes / perm changes) ------
    -a always,exit -F arch=b64 -S rename,renameat,renameat2,unlink,unlinkat,rmdir,truncate,ftruncate,chmod,fchmod,fchmodat,chown,fchown,fchownat,lchown,setxattr,lsetxattr,fsetxattr,removexattr,lremovexattr,fremovexattr -F exit=-EACCES ${user} -k failed_file_mod
    -a always,exit -F arch=b64 -S rename,renameat,renameat2,unlink,unlinkat,rmdir,truncate,ftruncate,chmod,fchmod,fchmodat,chown,fchown,fchownat,lchown,setxattr,lsetxattr,fsetxattr,removexattr,lremovexattr,fremovexattr -F exit=-EPERM ${user} -k failed_file_mod
    # fchmodat2 on separate lines: with -i an unknown syscall name drops the whole line
    -a always,exit -F arch=b64 -S fchmodat2 -F exit=-EACCES ${user} -k failed_file_mod
    -a always,exit -F arch=b64 -S fchmodat2 -F exit=-EPERM ${user} -k failed_file_mod

    # --- access modifications --------------------------------------------------
    -a always,exit -F arch=b64 -S chmod,fchmod,fchmodat ${user} -k perm_mod
    -a always,exit -F arch=b64 -S fchmodat2 ${user} -k perm_mod
    -a always,exit -F arch=b64 -S chown,fchown,fchownat,lchown ${user} -k perm_mod
    -a always,exit -F arch=b64 -S setxattr,lsetxattr,fsetxattr,removexattr,lremovexattr,fremovexattr ${user} -k perm_mod

    # --- deletions / moves -----------------------------------------------------
    -a always,exit -F arch=b64 -S unlink,unlinkat,rmdir,rename,renameat,renameat2 ${user} -k delete

    # --- special files ---------------------------------------------------------
    -a always,exit -F arch=b64 -S mknod,mknodat -k specialfiles

    # --- mounts (classic + new mount API used by util-linux >= 2.39) ----------
    -a always,exit -F arch=b64 -S mount,umount2,fsopen,fsmount,move_mount,open_tree,mount_setattr -F auid!=unset -k mount

    # --- kernel modules (syscalls cover insmod/modprobe/rmmod, all kmod links) -
    -a always,exit -F arch=b64 -S init_module,finit_module,delete_module -F auid!=unset -k modules

    # --- executions as root by logged-in users (sudo, su, setuid binaries) ----
    -a always,exit -F arch=b64 -S execve,execveat -F euid=0 ${user} -k sudo

    # --- ptrace ----------------------------------------------------------------
    -a always,exit -F arch=b64 -S ptrace -F a0=0x4 -k code_injection
    -a always,exit -F arch=b64 -S ptrace -F a0=0x5 -k data_injection
    -a always,exit -F arch=b64 -S ptrace -F a0=0x6 -k register_injection
    -a always,exit -F arch=b64 -S ptrace -k tracing

    # --- any 32-bit syscall (all systems are 64-bit) ---------------------------
    -a always,exit -F arch=b32 -S all -k 32bit
  '';

  mkHelper =
    name: runtimeInputs: text:
    pkgs.writeShellApplication {
      inherit name runtimeInputs text;
      bashOptions = [
        "errexit"
        "nounset"
      ];
    };

  # ak <key> [start]  - audit events for one key, readable (default start: today)
  # start: recent | today | yesterday | this-week | this-month | boot | "MM/DD/YYYY HH:MM:SS"
  ak = mkHelper "ak" [ pkgs.audit ] ''
    if [ $# -lt 1 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
      echo "usage: ak <key> [start]   e.g. ak file_integrity, ak sudo recent" >&2
      exit 1
    fi
    exec ausearch -k "$1" --start "''${2:-today}" -i --format text
  '';

  # aks [start]  - number of audit events per key (default start: today)
  aks = mkHelper "aks" [ pkgs.audit pkgs.coreutils ] ''
    aureport --key --summary --start "''${1:-today}" -i | tail -n +6
  '';

  # akl  - audit keys currently loaded in the kernel, with rule count per key (needs root)
  akl = mkHelper "akl" [ pkgs.audit pkgs.gnugrep pkgs.coreutils ] ''
    auditctl -l | grep -oP -- '(-k |key=)\K\S+' | sort | uniq -c | sort -rn
  '';
in
{
  users.groups.audit = {
    gid = 800;
    members = [ "root" ];
  };

  security.auditd = {
    enable = lib.mkDefault true;
    settings = {
      log_file = "/var/log/audit/audit.log";
      log_format = "ENRICHED";
      log_group = "audit";
      priority_boost = 4;
      flush = "INCREMENTAL_ASYNC";
      freq = 50;
      max_log_file = 100;
      max_log_file_action = "ROTATE";
      num_logs = 30;
      space_left = 100;
      space_left_action = "SYSLOG";
      admin_space_left = 50;
      admin_space_left_action = "SUSPEND";
      disk_full_action = "SUSPEND";
      disk_error_action = "SUSPEND";
    };
  };

  # Set audit=1 and audit_backlog_limit kernel params so audit events are
  # captured before auditd starts.
  security.audit = {
    enable = lib.mkForce true;
    backlogLimit = 8192;
  };

  # Disable the upstream auditctl-based service — replaced by ExecStartPre
  # below, which runs before auditd registers with the kernel and thus has no
  # kernel 6.18+ AUDIT_SET PID restriction.
  systemd.services.audit-rules-nixos.enable = false;

  systemd.services.auditd.serviceConfig = {
    ExecStartPre = "${lib.getExe' pkgs.audit "auditctl"} -R ${rules}";
    ExecStart = lib.mkForce [
      ""
      "${lib.getExe' pkgs.audit "auditd"} -l -s nochange"
    ];
  };

  environment.etc."audit/rules.d/audit.rules".source = rules;

  environment.systemPackages = lib.mkIf config.security.auditd.enable [
    ak
    aks
    akl
  ];
}
