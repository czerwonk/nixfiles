{ username, extraHomeModules, ... }:

{
  imports = [
  ] ++ extraHomeModules;

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "23.05";
  };
  programs.home-manager.enable = true;
}
