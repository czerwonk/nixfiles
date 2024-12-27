{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      ghostty
    ];
    file.".config/ghostty/config".text = builtins.readFile ./config;
  };
}
