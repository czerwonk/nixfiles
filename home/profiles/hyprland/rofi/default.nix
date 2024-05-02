{ pkgs, lib, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    plugins = with pkgs; [
      rofi-calc
      rofi-emoji
    ];
    terminal = lib.getExe pkgs.kitty;
    font = "JetBrains Mono";
    theme = ./theme.rasi;
    extraConfig = {
      #modi = "window,drun,calc,emoji";
      modi = "window,drun";
      show-icons = true;
      drun-display-format = "{icon} {name}";
      disable-history = false;
      display-drun = "   Apps ";
      display-run = "   Run ";
      display-emoji = "   Emoji ";
      display-calc = "   Calc ";
    };
  };
}
