{ username, extraHomeModules, ... }:

{
  imports = [
    ../../../home/profiles/core/minimal-packages.nix
    ../../../home/programs/bat
    ../../../home/programs/fzf
    ../../../home/programs/kitty
    ../../../home/programs/zsh
  ] ++ extraHomeModules;

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;
}
