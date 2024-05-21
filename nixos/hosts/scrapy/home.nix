{ extraHomeModules, ... }:

{
  imports = [
    ../../../home/linux.nix
    ../../../home/profiles/desktop/hyprland
    ../../../home/profiles/devops
  ] ++ extraHomeModules;

  profiles.hyprland = {
    backlightDevice = "intel_backlight";
    extraConfig = ''
      monitor=HDMI-A-1,preferred,0x0,1.0
      monitor=eDP-1,preferred,auto,1.6
    '';
  };
}
