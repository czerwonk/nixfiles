{ lib, ... }:
with lib;

{
  options = {
    suits.hyprland.backlight_device = mkOption {
      type = types.str;
      description = mdDoc "Set the device driver name for backlight information/control";
    };
  };
}
