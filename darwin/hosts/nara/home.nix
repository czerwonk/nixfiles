{ extraHomeModules, ... }:

{
  imports = [
    ../../../home/osx
    ../../../home/profiles/desktop/common.nix
    ../../../home/profiles/devops
  ] ++ extraHomeModules;
}
