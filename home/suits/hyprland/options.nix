{ lib, ... }:
with lib;

{
  options = {
    suits.hyprland.backlightDevice = mkOption {
      type = types.str;
      description = mdDoc "Set the device driver name for backlight information/control";
    };

    suits.hyprland.externalMonitor = mkOption {
      type = types.str;
      description = mdDoc "Name of the external monitor";
    };
  };
}
