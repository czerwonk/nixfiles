{ extraHomeModules, ... }:

{
  imports = [
    ../../../home/linux.nix
    ../../../home/profiles/desktop
    ../../../home/profiles/devops
    ../../../home/profiles/hyprland
  ] ++ extraHomeModules;

  profiles.hyprland = {
    backlightDevice = "intel_backlight";
    extraConfig = ''
      monitor=eDP-1,preferred,auto,1.6
    '';
  };
}
