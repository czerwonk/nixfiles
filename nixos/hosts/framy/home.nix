{ extraHomeModules, ... }:

{
  imports = [
    ../../../home/linux.nix
    ../../../home/profiles/desktop
    ../../../home/profiles/devops
    ../../../home/profiles/pentest
    ../../../home/profiles/hyprland
    ../../../home/profiles/performance
  ] ++ extraHomeModules;

  profiles.hyprland = {
    backlightDevice = "amdgpu_bl0";
    externalMonitor = "DP-2";
    extraConfig = ''
      monitor=eDP-1,preferred,auto,auto
    '';
  };
}
