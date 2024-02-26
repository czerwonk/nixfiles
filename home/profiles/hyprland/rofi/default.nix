{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    plugins = with pkgs; [
      rofi-calc
      rofi-emoji
    ];
    terminal = "${pkgs.kitty}/bin/kitty";
    font = "JetBrains Mono";
    theme = ./theme.rasi;
    extraConfig = {
      modi = "window,drun,calc,emoji";
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
