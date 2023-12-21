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

  suits.hyprland = {
    backlightDevice = "amdgpu_bl0";
    externalMonitor = "DP-2";
  };
}
