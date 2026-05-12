{ lib, ... }:
with lib;

{
  options = {
    profiles.hyprland.extraConfig = mkOption {
      type = types.lines;
      description = mdDoc "Device specific configuration";
      default = "";
    };
  };
}
