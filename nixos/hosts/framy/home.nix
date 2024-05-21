{ extraHomeModules, ... }:

{
  imports = [
    ../../../home/linux.nix
    ../../../home/profiles/desktop/hyprland
    ../../../home/profiles/devops
    ../../../home/profiles/pentest
  ] ++ extraHomeModules;

  profiles.hyprland = {
    backlightDevice = "amdgpu_bl0";
    extraConfig = ''
      monitor=DP-3,preferred,0x0,1.0
      monitor=eDP-1,preferred,auto,1.6
    '';
  };
}
