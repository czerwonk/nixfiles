{ username, extraHomeModules, ... }:

{
  imports = [
    ../../../home/profiles/core/minimal-packages.nix
    ../../../home/profiles/kitty
    ../../../home/programs/bat
    ../../../home/programs/fzf
    ../../../home/programs/zsh
  ] ++ extraHomeModules;

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;
}
