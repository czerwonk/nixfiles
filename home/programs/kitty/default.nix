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
      color2 = "#98BB6C";
      color7 = "#E6C384";
      color31 = "#7FB4CA";
    };
  };
}
