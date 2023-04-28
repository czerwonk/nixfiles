{  config, lib, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      package = pkgs.meslo-lgs-nf;
      name = "MesloLGS NF";
      size = 14;
    };
    settings = {
      enable_audio_bell = false;
      hide_window_decorations = true;
      foreground = "#E1D9D1";
      color1 = "#C34043";
      color2 = "#76946A";
      color3 = "#E6C384";
      color4 = "#658594";
      color31 = "#7FB4CA";
      color75 = "#FF9E3B";
      color76 = "#98BB6C";
    };
  };
}
