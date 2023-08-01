{ username, ... }:

{
  imports = [
    ./default.nix
    ./suits/linux-utils
  ];
  
  home = {
    username = username;
    homeDirectory = if username == "root" then "/root" else "/home/${username}";
  };
}
