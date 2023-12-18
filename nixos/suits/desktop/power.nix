{ lib, ... }:

{
  boot.kernelParams = [ "mem_sleep_default=deep" ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";

  services.tlp = {
    enable = true;
    settings = {
      CPU_BOOST_ON_BAT = 0;

      START_CHARGE_THRESH_BAT0 = 90;
      STOP_CHARGE_THRESH_BAT0 = 97;

      RUNTIME_PM_ON_BAT = "auto";

      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    };
  };

  services.power-profiles-daemon.enable = false; # conflicts with tlp
}
