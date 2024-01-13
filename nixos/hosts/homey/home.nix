{ extraHomeModules, ... }:

{
  imports = [
    ../../../home/linux.nix
    ../../../home/suits/server
  ] ++ extraHomeModules;
}
