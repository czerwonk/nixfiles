{ extraHomeModules, ... }:

{
  imports = [
    ../../home.nix
    ../../../home/profiles/devops
  ] ++ extraHomeModules;
}
