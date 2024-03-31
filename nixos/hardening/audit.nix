{
  security.audit = {
    enable = "lock";
    backlogLimit = 8192;
    rules = [
      # file integrity monitoring
      "-w /etc/sudoers -p wa -k file_integrity"
      "-w /etc/passwd -p wa -k file_integrity"
      "-w /etc/group -p wa -k file_integrity"
      "-w /etc/shadow -k file_integrity"
      "-w /etc/sysctl.conf -p wa -k file_integrity"
      "-w /etc/sysctl.d -p wa -k file_integrity"
      "-w /etc/login.defs -p wa -k file_integrity"
      "-w /etc/hosts -p wa -k file_integrity"
      "-w /etc/systemd/network -p wa -k file_integrity"
      "-w /etc/pam.d/ -p wa -k file_integrity"
      "-w /etc/security/limits.conf -p wa -k file_integrity"
      "-w /etc/ssh/sshd_config -p wa -k file_integrity"
      "-w /etc/systemd/ -p wa -k file_integrity"
      "-a always,exit -F dir=/etc/NetworkManager/ -F perm=wa -k file_integrity"

      # executions
      "-a always,exit -F arch=b64 -S execve -F euid=0 -F auid>=1000 -F auid!=-1 -S execve -k sudo"
      "-a always,exit -F arch=b64 -S mount -S umount2 -F auid!=-1 -k mount"
      "-a always,exit -F arch=b64 -S mknod -S mknodat -k specialfiles"

      # modules
      "-a always,exit -F perm=x -F auid!=-1 -F path=/sbin/insmod -k modules"
      "-a always,exit -F perm=x -F auid!=-1 -F path=/sbin/modprobe -k modules"
      "-a always,exit -F perm=x -F auid!=-1 -F path=/sbin/rmmod -k modules"
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
