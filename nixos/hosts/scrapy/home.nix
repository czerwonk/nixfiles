{ extraHomeModules, ... }:

{
  imports = [
    ../../../home/linux.nix
    ../../../home/suits/desktop
    ../../../home/suits/devops
    ../../../home/suits/hyprland
  ] ++ extraHomeModules;

  suits.hyprland = {
    backlightDevice = "intel_backlight";
    externalMonitor = "HDMI-A-1";
    extraConfig = ''
      monitor=eDP-1,preferred,auto,1.5
    '';
  };
}
