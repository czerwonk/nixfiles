{ extraHomeModules, lib, ... }:

{
  imports = [
    ../../../home/linux.nix
    ../../../home/suits/desktop
    ../../../home/suits/devops
    ../../../home/suits/pentest
    ../../../home/services/grive2
    ../../../home/programs/hyprland
  ] ++ extraHomeModules;

  services.grive2.enable = true;
}
