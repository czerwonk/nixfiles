{
  networking.firewall.enable = true;
  networking.firewall.checkReversePath = "loose";

  security.apparmor.enable = true;
  security.apparmor.killUnconfinedConfinables = true;
  services.fail2ban = {
    enable = true;
  };

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
}
