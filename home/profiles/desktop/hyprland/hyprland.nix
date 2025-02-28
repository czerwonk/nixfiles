{ pkgs, lib, config, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd = {
      enable = true;
      variables = ["--all"];
    };
    settings = {
      monitor = ",preferred,auto,auto";
      input = {
        kb_layout = "us";
        kb_variant = "altgr-intl";
        kb_options = "caps:escape";
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
      xwayland = {
        force_zero_scaling = true;
      };
    };
    extraConfig = ''
      ${config.profiles.hyprland.extraConfig}

      env = GDK_BACKEND, wayland
      env = MOZ_ENABLE_WAYLAND, 1
      env = NIXOS_OZONE_WL, 1
      env = QT_QPA_PLATFORM, wayland
      env = QT_WAYLAND_DISABLE_WINDOWDECORATION, 1
      env = QT_AUTO_SCREEN_SCALE_FACTOR, 1
      env = SDL_VIDEODRIVER, wayland
      env = XDG_SESSION_TYPE, wayland
      env = GTK_THEME, ${config.gtk.theme.name}

      exec-once = ${lib.getExe pkgs.waybar}
      exec-once = ${lib.getExe pkgs.wlsunset} -l -23 -L -46
      exec-once = ${lib.getExe pkgs.hyprpaper}
      exec-once = ${pkgs.systemd}/bin/systemctl --user start swayidle
      exec-once = [workspace 2] ${lib.getExe pkgs.ghostty} ${lib.getExe pkgs.tmux} a
      exec-once = [workspace 3 silent] /run/current-system/sw/bin/librewolf
      exec-once = [workspace 4 silent] /run/current-system/sw/bin/thunderbird
      exec-once = [workspace 9 silent] /run/current-system/sw/bin/teams-for-linux
      exec-once = [workspace 10 silent] ${lib.getExe pkgs.bitwarden}
      exec-once = sleep 1; ${lib.getExe pkgs.nextcloud-client} --background

      $mainMod = SUPER

      bind = $mainMod, B, exec, /run/current-system/sw/bin/librewolf
      bind = $mainMod, E, exec, ${pkgs.nautilus}/bin/nautilus
      bind = $mainMod, F, fullscreen,
      bind = $mainMod, P, pseudo, # dwindle
      bind = $mainMod, S, exec, hypr-screenshot
      bind = $mainMod, T, exec, ${lib.getExe pkgs.ghostty}
      bind = $mainMod, V, togglefloating,
      bind = $mainMod, W, killactive,
      bind = $mainMod, SPACE, exec, rofi -show drun
      bind = $mainMod, TAB, exec, rofi -show window
      bind = $mainMod SHIFT, E, exec, rofi -show emoji
      bind = $mainMod SHIFT, F, togglefloating,
      bind = $mainMod SHIFT, L, exec, ${lib.getExe config.programs.swaylock.package}
      bind = $mainMod SHIFT, P, pin,
      bind = $mainMod SHIFT, Q, exec, hypr-logout
      bind = $mainMod SHIFT, R, exec, hypr-reboot
      bind = $mainMod SHIFT, S, exec, ${pkgs.systemd}/bin/systemctl suspend -i
      bind = ,XF86PowerOff, exec, hypr-halt
      bind = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bind = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
      binde = ,XF86MonBrightnessDown, exec, ${lib.getExe pkgs.brightnessctl} set 1%-
      binde = ,XF86MonBrightnessUp, exec, ${lib.getExe pkgs.brightnessctl} set +1%
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

      windowrulev2 = float,class:^(steam)$,title:^(?!.*(Library|Steam)).*$
      windowrulev2 = stayfocused, title:^()$,class:^(steam)$
      windowrulev2 = minsize 1 1, title:^()$,class:^(steam)$
    '';
  };
}
