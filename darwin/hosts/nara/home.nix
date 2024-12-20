{ extraHomeModules, ... }:

{
  imports = [
    ../../../home/osx
    ../../../home/profiles/desktop/common.nix
    ../../../home/profiles/devops
  ] ++ extraHomeModules;

  programs.kitty = {
    settings = {
      hide_window_decorations = false;
      background_opacity = "0.99";
    };
  };
}
