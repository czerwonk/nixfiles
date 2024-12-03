{ pkgs, extraHomeModules, ... }:

{
  imports = [
    ../../home
    ../../home/profiles/linux-utils
  ] ++ extraHomeModules;

  programs.tmux = {
    package = pkgs.tmux;
    shortcut = "b";
    position = "bottom";
  };
}
