{ extraHomeModules, ... }:

{
  imports = [
    ../../../home/linux.nix
    ../../../home/suits/desktop
    ../../../home/suits/devops
    ../../../home/suits/pentest
    ../../../home/services/grive2
    ../../../home/suits/hyprland
  ] ++ extraHomeModules;

  services.grive2.enable = true;

  suits.hyprland.backlight_device = "intel_backlight";
}
