{ lib, config, ... }:
with lib;

let
  cfg = config.suits.desktop;

in {
  options = {
    suits.desktop.enablePowerManagement = mkOption {
      type = types.bool;
      default = false;
      description = lib.mdDoc "Wether to enable power management (notebooks only)";
    };
  };

  config = mkIf cfg.enablePowerManagement {
    powerManagement.cpuFreqGovernor = mkDefault "ondemand";

    services.tlp = {
      enable = true;
      settings = {
        CPU_BOOST_ON_BAT = 0;

        START_CHARGE_THRESH_BAT0 = 80;
        STOP_CHARGE_THRESH_BAT0 = 97;

        RUNTIME_PM_ON_BAT = "auto";

        CPU_SCALING_GOVERNOR_ON_AC = "${config.powerManagement.cpuFreqGovernor}";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      };
    };

    services.power-profiles-daemon.enable = false; # conflicts with tlp
  };
}
