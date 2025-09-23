{ extraHomeModules, ... }:

{
  imports = [
    ../../home
    ../../home/profiles/linux-utils
    ../../home/programs/hakanai
  ]
  ++ extraHomeModules;

  programs.tmux = {
    shortcut = "b";
    position = "bottom";
  };
}
