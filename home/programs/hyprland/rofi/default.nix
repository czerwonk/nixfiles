{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    plugins = [ pkgs.rofi-emoji ];
    terminal = "${pkgs.kitty}/bin/kitty";
    font = "JetBrains Mono";
    theme = ./theme.rasi;
  };
}
