{ extraHomeModules, ... }:

{
  imports = [
    ../../../home/linux.nix
  ] ++ extraHomeModules;
}
