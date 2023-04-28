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
      color2 = "#98BB6C";
      color7 = "#E6C384";
      color15 = "#DCD7BA";
      color31 = "#7FB4CA";
    };
  };
}
