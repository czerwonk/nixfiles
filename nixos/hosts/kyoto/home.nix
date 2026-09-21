{ extraHomeModules, ... }:

{
  imports = [
    ../../../home/linux.nix
    ../../../home/profiles/desktop/cosmic
    ../../../home/profiles/desktop/cosmic/default-applications.nix
    ../../../home/profiles/desktop/workstation.nix
    ../../../home/profiles/devops
    ../../../home/profiles/static-web
  ]
  ++ extraHomeModules;
}
