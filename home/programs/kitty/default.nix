{  config, lib, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      package = pkgs.meslo-lgs-nf;
      name = "Meslo LG L";
      size = 14;
    };
    settings = {
      enable_audio_bell = false;
      hide_window_decorations = true;
    };
  };
}
