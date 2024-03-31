{
  security.apparmor.enable = true;
  security.apparmor.killUnconfinedConfinables = true;

  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
  };

  services.sysstat.enable = true;

  security.rtkit.enable = true;
}
