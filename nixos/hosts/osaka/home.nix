{ extraHomeModules, ... }:

{
  imports = [
    ../../../home/linux.nix
    ../../../home/profiles/desktop/cosmic
    ../../../home/profiles/desktop/workstation.nix
    ../../../home/profiles/devops
  ]
  ++ extraHomeModules;
}
