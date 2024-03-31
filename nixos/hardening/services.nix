{
  security.apparmor.enable = true;
  security.apparmor.killUnconfinedConfinables = true;

  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
  };

  services.sysstat.enable = true;

  security.audit = {
    enable = true;
    backlogLimit = 8192;
    rules = [
      "-a exit,always -F arch=b64 -F euid=0 -S execve"
    ];
  };
  security.auditd.enable = true;

  security.rtkit.enable = true;
}
