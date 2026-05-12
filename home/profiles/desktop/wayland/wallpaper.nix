{ config, ... }:

{
  services.swaybg = {
    enable = true;
    image = "${config.home.homeDirectory}/.config/bg.jpg";
    mode = "fill";
  };
}
