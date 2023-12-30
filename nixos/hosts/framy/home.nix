{ extraHomeModules, ... }:

{
  imports = [
    ../../../home/linux.nix
    ../../../home/suits/desktop
    ../../../home/suits/devops
    ../../../home/suits/pentest
    ../../../home/suits/hyprland
  ] ++ extraHomeModules;

  suits.hyprland = {
    backlightDevice = "amdgpu_bl0";
    externalMonitor = "DP-2";
  };
}
