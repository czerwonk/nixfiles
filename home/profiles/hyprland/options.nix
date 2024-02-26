{ lib, ... }:
with lib;

{
  options = {
    profiles.hyprland.backlightDevice = mkOption {
      type = types.str;
      description = mdDoc "Set the device driver name for backlight information/control";
    };

    profiles.hyprland.externalMonitor = mkOption {
      type = types.str;
      description = mdDoc "Name of the external monitor";
    };

    profiles.hyprland.extraConfig = mkOption {
      type = types.lines;
      description = mdDoc "Device spcific configuration";
      default = "";
    };
  };
}
