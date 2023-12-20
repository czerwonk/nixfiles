{ pkgs, ... }:

{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      color = "808080";
      font-size = 24;
      indicator-idle-visible = false;
      indicator-radius = 100;
      line-color = "ffffff";
      show-failed-attempts = true;
      screenshots = true;
      indicator = true;
      effect-blur = "7x5";
      grace = 5;
    };
  };
}
