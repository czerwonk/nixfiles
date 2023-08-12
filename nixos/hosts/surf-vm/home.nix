{ username, extraHomeModules, ... }:

{
  imports = [
    ../../../home/programs/zsh
    ../../../home/programs/bat
    ../../../home/programs/fzf
    ../../../home/suits/core/packages.nix
  ] ++ extraHomeModules;

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "23.05";
  };
  programs.home-manager.enable = true;
}
