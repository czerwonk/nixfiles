{ username, extraHomeModules, ... }:

{
  imports = [
    ../../../home/programs/zsh
    ../../../home/programs/bat
    ../../../home/programs/fzf
    ../../../home/suits/core/minimal-packages.nix
  ] ++ extraHomeModules;

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;
}
