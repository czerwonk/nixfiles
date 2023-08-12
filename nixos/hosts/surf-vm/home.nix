{ username, extraHomeModules, ... }:

{
  imports = [
  ] ++ extraHomeModules;

  home = {
    username = username;
    homeDirectory = "/home/${username}";
  };
}
