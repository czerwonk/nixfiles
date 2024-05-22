{ extraHomeModules, ... }:

{
  imports = [
    ../../../home/linux.nix
    ../../../home/profiles/desktop/gnome
    ../../../home/profiles/devops
    ../../../home/profiles/pentest
  ] ++ extraHomeModules;
}
