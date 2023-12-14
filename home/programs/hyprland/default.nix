{ pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      input = {
        kb_layout = "us";
        kb_variant = "altgr-intl";
      };
      general = {
        gaps_in = 3;
        gaps_out = 3;
        border_size = 1;
      };
      blur.enabled = false;
    };
    extraConfig = ''
      exec-once=waybar
      exec-once=wlsunset -l -23 -L -46
      exec-once=dunst
      exec-once=

      bind = $mainMod, B, exec, brave
    '';
  };
}
