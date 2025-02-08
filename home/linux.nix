{ username, pkgs, ... }:

{
  imports = [
    ./default.nix
    ./profiles/linux-utils
  ];

  home = {
    username = username;
    homeDirectory = if username == "root" then "/root" else "/home/${username}";
    packages = with pkgs; [
      iputils
      traceroute
    ];
  };
}
