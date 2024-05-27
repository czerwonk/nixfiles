{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal.wlr = {
    enable = true;
    settings = {
      screencast = {
        chooser_type = "simple";
        chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -ro";
      };
    };
  };

  security.pam.services.swaylock.u2fAuth = false;
  security.pam.services.swaylock.fprintAuth = false;
}
