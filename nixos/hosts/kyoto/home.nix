{ extraHomeModules, ... }:

{
  imports = [
    ../../../home/linux.nix
    ../../../home/profiles/desktop/gnome
    ../../../home/profiles/desktop/workstation.nix
    ../../../home/profiles/devops
    ../../../home/programs/zed
  ]
  ++ extraHomeModules;
}
