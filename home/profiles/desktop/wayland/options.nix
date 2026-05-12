{ lib, ... }:
with lib;

{
  options = {
    profiles.wayland.backlightDevice = mkOption {
      type = types.str;
      description = mdDoc "Set the device driver name for backlight information/control";
    };
  };
}
