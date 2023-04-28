{  config, lib, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    theme = "kanagawabones";
    font = {
      package = pkgs.meslo-lgs-nf;
      name = "MesloLGS NF";
      size = 14;
    };
    settings = {
      enable_audio_bell = false;
    };
  };
}
