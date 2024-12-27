{ extraHomeModules, ... }:

{
  imports = [
    ../../../home/osx
    ../../../home/profiles/desktop/common.nix
    ../../../home/profiles/devops
  ] ++ extraHomeModules;

  my.programs.ghostty.extraConfig = ''
    macos-titlebar-style = hidden
    background-opacity = 0.99
  '';
}
