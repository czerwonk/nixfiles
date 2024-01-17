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
    extraConfig = ''
      monitor=eDP-1,preferred,auto,1.5
    '';
  };
}
