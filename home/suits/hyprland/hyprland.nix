{ pkgs, config, ... }:
let
  screenshot = pkgs.writeScriptBin "screenshot" ''
    #!${pkgs.stdenv.shell}
    ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | ${pkgs.swappy}/bin/swappy -f -
  '';

in {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
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
        drop_shadow = false;
      };
      misc = {
        force_default_wallpaper = 0;
        vfr = true;
      };
    };
    extraConfig = ''
      exec-once = ${pkgs.waybar}/bin/waybar
      exec-once = ${pkgs.wlsunset}/bin/wlsunset -l -23 -L -46
      exec-once = ${pkgs.hyprpaper}/bin/hyprpaper
      exec-once = ${pkgs.systemd}/bin/systemctl --user start swayidle
      exec-once = ${pkgs.nextcloud-client}/bin/nextcloud --background
      exec-once = [workspace 2] ${pkgs.kitty}/bin/kitty ${pkgs.tmux}/bin/tmux a
      exec-once = [workspace 3 silent] ${pkgs.brave}/bin/brave
      exec-once = [workspace 4 silent] ${pkgs.thunderbird}/bin/thunderbird
      exec-once = [workspace 5 silent] ${pkgs.element-desktop}/bin/element-desktop

      $mainMod = SUPER

      bind = $mainMod, T, exec, ${pkgs.kitty}/bin/kitty
      bind = $mainMod, W, killactive,
      bind = $mainMod, E, exec, ${pkgs.gnome.nautilus}/bin/nautilus
      bind = $mainMod, V, togglefloating,
      bind = $mainMod, SPACE, exec, ${config.programs.rofi.package}/bin/rofi -show drun
      bind = $mainMod, TAB, exec, ${config.programs.rofi.package}/bin/rofi -show window
      bind = $mainMod, P, pseudo, # dwindle
      bind = $mainMod, S, exec, ${screenshot}/bin/screenshot
      bind = $mainMod, F, fullscreen,
      bind = $mainMod, B, exec, ${pkgs.brave}/bin/brave
      bind = $mainMod SHIFT, L, exec, ${config.programs.swaylock.package}/bin/swaylock
      bind = $mainMod SHIFT, P, pin,
      bind = $mainMod SHIFT, F, togglefloating,
      bind = $mainMod SHIFT, Q, exit,
      bind = $mainMod SHIFT, S, exec, ${pkgs.systemd}/bin/systemctl suspend -i
      bind = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bind = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
      binde = ,XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 1%-
      binde = ,XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl set +1%
      binde = ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 1%+
      binde = ,XF86AudioLowerVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 1%-

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

      # Scratchpad
      bind= $mainMod + SHIFT, H, movetoworkspace, special
      bind= $mainMod, H, togglespecialworkspace
    '';
    systemd.enable = false;
  };
}
