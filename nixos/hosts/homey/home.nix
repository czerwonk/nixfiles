{ extraHomeModules, ... }:

{
  imports = [
    ../../../home/linux.nix
    ../../../home/suits/server
    ../../../home/suits/devops
  ] ++ extraHomeModules;
}
