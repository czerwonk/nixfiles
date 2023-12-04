{ pkgs, lib, ... }:

{
  programs.kitty = {
    enable = lib.mkDefault true;
    font = {
      package = pkgs.jetbrains-mono;
      name = "JetBrains Mono";
      size = 14;
    };
    settings = {
      copy_on_select = true;
      font_size_delta = 1;
      text_composition_strategy = "1.0 0";
      enable_audio_bell = false;
      hide_window_decorations = true;
      foreground = "#E1D9D1";
      background = "#1F1F28";
      color1 = "#C34043";
      color2 = "#76946A";
      color3 = "#E6C384";
      color4 = "#7FB4CA";
      color11 = "#FF9E3B";
      color31 = "#A3D4D5";
      color76 = "#98BB6C";
      color234 = "#1F1F28";
    };
  };
}
