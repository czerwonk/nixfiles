{ extraHomeModules, ... }:

{
  imports = [
    ../../../home/linux.nix
    ../../../home/suits/devops
  ] ++ extraHomeModules;
}
