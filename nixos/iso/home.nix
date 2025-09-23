{ extraHomeModules, ... }:

{
  imports = [
    ../../home
    ../../home/profiles/linux-utils
  ]
  ++ extraHomeModules;

  programs.tmux = {
    shortcut = "b";
    position = "bottom";
  };
}
