{ extraHomeModules, ... }:

{
  imports = [
    ../../../home/linux.nix
    ../../../home/profiles/server
    ../../../home/profiles/devops
  ] ++ extraHomeModules;
}
