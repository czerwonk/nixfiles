{ extraHomeModules, ... }:

{
  imports = [
    ../../../home/linux.nix
    ../../../home/profiles/server
    ../../../home/profiles/static-web
  ]
  ++ extraHomeModules;
}
