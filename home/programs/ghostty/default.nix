{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      ghostty
      jetbrains-mono
    ];
    file.".config/ghostty/config".text = builtins.readFile ./config;
  };
}
