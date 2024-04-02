{
  users.groups.audit = {
    gid = 800;
    members = [ "root" ];
  };

  environment.etc."audit/auditd.conf".text = ''
    log_file = /var/log/audit/audit.log
    log_format = RAW
    log_group = audit
    priority_boost = 4
    flush = INCREMENTAL
    freq = 50
    max_log_file = 100
    max_log_file_action = ROTATE
    num_logs = 20
    admin_space_left = 512
    admin_space_left_action = suspend
    disk_full_action = SUSPEND
    disk_error_action = SUSPEND
  '';

  security.audit = {
    enable = "lock";
    backlogLimit = 8192;
    rules = [
      "-i" # ignore missing users or files

      # failed file access
      "-a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=-1 -k failed_access"
      "-a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=-1 -k failed_access"
      "-a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=-1 -k failed_access"
      "-a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=-1 -k failed_access"

      # access modifications
      "-a always,exit -F arch=b64 -S chmod -S fchmod -S fchmodat -F auid>=1000 -F auid!=-1 -k perm_mod"
      "-a always,exit -F arch=b32 -S chmod -S fchmod -S fchmodat -F auid>=1000 -F auid!=-1 -k perm_mod"
      "-a always,exit -F arch=b64 -S chown -S fchown -S fchownat -S lchown -F auid>=1000 -F auid!=-1 -k perm_mod"
      "-a always,exit -F arch=b32 -S chown -S fchown -S fchownat -S lchown -F auid>=1000 -F auid!=-1 -k perm_mod"
      "-a always,exit -F arch=b64 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=1000 -F auid!=-1 -k perm_mod"
      "-a always,exit -F arch=b32 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=1000 -F auid!=-1 -k perm_mod"

      # file integrity monitoring
      "-w /etc/sudoers -p wa -k file_integrity"
      "-w /etc/passwd -p wa -k file_integrity"
      "-w /etc/group -p wa -k file_integrity"
      "-w /etc/shadow -k file_integrity"
      "-w /etc/sysctl.conf -p wa -k file_integrity"
      "-w /etc/sysctl.d -p wa -k file_integrity"
      "-w /etc/login.defs -p wa -k file_integrity"
      "-w /etc/hosts -p wa -k file_integrity"
      "-w /etc/pam.d/ -p wa -k file_integrity"
      "-w /etc/ssh/sshd_config -p wa -k file_integrity"
      "-a always,exit -F dir=/etc/NetworkManager/ -F perm=wa -k file_integrity"
      "-w /etc/localtime -p wa -k file_integrity"
      "-w /var/log/sudo-io -p wra -k file_integrity"

      # systemd
      "-w /run/current-system/sw/bin/systemctl -p x -k systemd"
      "-w /etc/systemd/ -p wa -k systemd"
      "-w /usr/lib/systemd -p wa -k systemd"

      # executions
      "-a always,exclude -F msgtype=CWD"
      "-a always,exit -F arch=b64 -S execve -F euid=0 -F auid>=1000 -F auid!=-1 -S execve -k sudo"
      "-a always,exit -F arch=b32 -S execve -F euid=0 -F auid>=1000 -F auid!=-1 -S execve -k sudo"
      "-a always,exit -F arch=b64 -S mount -S umount2 -F auid!=-1 -k mount"
      "-a always,exit -F arch=b64 -S mknod -S mknodat -k specialfiles"

      # deletions
      "-a always,exit -F arch=b64 -S unlink -S unlinkat -S rename -S renameat -F auid>=1000 -F auid!=-1 -k delete"
      "-a always,exit -F arch=b32 -S unlink -S unlinkat -S rename -S renameat -F auid>=1000 -F auid!=-1 -k delete"

      # modules
      "-a always,exit -F perm=x -F auid!=-1 -F path=/run/current-system/sw/bin/insmod -k modules"
      "-a always,exit -F perm=x -F auid!=-1 -F path=/run/current-system/sw/bin/modprobe -k modules"
      "-a always,exit -F perm=x -F auid!=-1 -F path=/run/current-system/sw/bin/rmmod -k modules"
      "-a always,exit -F arch=b64 -S finit_module -S init_module -S delete_module -F auid!=-1 -k modules"

      # ptrace
      "-a always,exit -F arch=b64 -S ptrace -F a0=0x4 -k code_injection"
      "-a always,exit -F arch=b64 -S ptrace -F a0=0x5 -k data_injection"
      "-a always,exit -F arch=b64 -S ptrace -F a0=0x6 -k register_injection"
      "-a always,exit -F arch=b64 -S ptrace -k tracing"
    ];
  };
  security.auditd.enable = true;
}
