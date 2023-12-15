{ pkgs, username, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = ",preferred,auto,auto";
      input = {
        kb_layout = "us";
        kb_variant = "altgr-intl";
      };
      general = {
        gaps_in = 3;
        gaps_out = 3;
        border_size = 1;
        "col.active_border" = "rgba(c8c093ff)";
        layout = "dwindle";
      };
      decoration = {
        rounding = 10;
        blur.enabled = false;
      };
    };
    extraConfig = ''
      exec-once=${pkgs.waybar}/bin/waybar
      exec-once=${pkgs.wlsunset}/bin/wlsunset -l -23 -L -46
      exec-once=${pkgs.dunst}/bin/dunst
      exec-once=${pkgs.hyprpaper}/bin/hyprpaper
      exec-once=

      $mainMod = SUPER

      bind = $mainMod, T, exec, ${pkgs.kitty}/bin/kitty
      bind = $mainMod, W, killactive,
      bind = $mainMod, E, exec, ${pkgs.gnome.nautilus}/bin/nautilus
      bind = $mainMod, V, togglefloating,
      bind = $mainMod, R, exec, ${pkgs.rofi}/bin/rofi -theme solarized -show drun
      bind = $mainMod, P, pseudo, # dwindle
      bind = $mainMod, S, togglesplit, # dwindle
      bind = $mainMod, F, fullscreen,
      bind = $mainMod, B, exec, ${pkgs.brave}/bin/brave
      bind = $mainMod SHIFT, L, exec, ${pkgs.swaylock-effects}/bin/swaylock --screenshots --indicator --effect-blur 7x5
      bind = $mainMod SHIFT, P, pin,
      bind = $mainMod SHIFT, F, togglefloating,
      bind = $mainMod SHIFT, Q, exit,

      # Move focus
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d

      # Move window
      bind = $mainMod SHIFT, H, movewindow, l
      bind = $mainMod SHIFT, L, movewindow, r
      bind = $mainMod SHIFT, K, movewindow, u
      bind = $mainMod SHIFT, J, movewindow, d

      # Switch workspace
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      # Move active window to a workspace
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow
    '';
    systemd.enable = false;
  };

  home.file.".config/hypr/hyprpaper.conf".text = ''
    ipc = off
    preload = /home/${username}/.config/bg.jpg
    wallpaper = eDP-1,/home/${username}/.config/bg.jpg
    wallpaper = HDMI-A-1,/home/${username}/.config/bg.jpg
  '';
  home.file.".config/waybar/config".source = ./waybar/config;
}
