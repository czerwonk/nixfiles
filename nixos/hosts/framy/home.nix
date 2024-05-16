{ extraHomeModules, ... }:

{
  imports = [
    ../../../home/linux.nix
    ../../../home/profiles/desktop
    ../../../home/profiles/devops
    ../../../home/profiles/pentest
    ../../../home/profiles/hyprland
  ] ++ extraHomeModules;

  profiles.hyprland = {
    backlightDevice = "amdgpu_bl0";
    extraConfig = ''
      monitor=eDP-1,preferred,auto,1.6
    '';
  };
}
