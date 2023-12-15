{
  programs.waybar = {
    enable = true;
    settings.mainBar = {
      height = 10;
      spacing = 3;
      modules-center = [ "hyprland/window" ];
      modules-left = [ "hyprland/workspaces" ];
      modules-right = [
        "pulseaudio"
        "network"
        "keyboard-state"
        "battery"
        "clock"
      ];
      battery = {
        format = "{capacity}% {icon}";
        format-alt = "{time} {icon}";
        format-charging = "{capacity}% ";
        format-icons = [ "" "" "" "" "" ];
        format-plugged = "{capacity}% ";
      };
      clock = {
        timezone = "Europe/Berlin";
      };
      "hyprland/workspaces" = {
        format = "{name}: {icon}";
        format-icons = {
         "default" = "";
         "focused" = "";
         "urgent" = "";
        };
      };
      keyboard-state = {
        format = "{name} {icon}";
        format-icons = {
          locked = "";
          unlocked = "";
        };
      };
      network = {
        format-alt = "{ifname}: {ipaddr}/{cidr}";
        format-disconnected = "Disconnected ⚠";
        format-ethernet = "{ipaddr}/{cidr} ";
        format-linked = "{ifname} (No IP) ";
        format-wifi = "{essid} ({signalStrength}%) ";
        tooltip-format = "{ifname} via {gwaddr} ";
      };
      pulseaudio = {
        format = "{volume}% {icon} {format_source}";
        format-bluetooth = "{volume}% {icon} {format_source}";
        format-bluetooth-muted = " {icon} {format_source}";
        format-icons = {
          "default" = [ "" "" "" ];
          "headphone" = "";
        };
        format-muted = " {format_source}";
        format-source = "{volume}% ";
        format-source-muted = "";
      };
    };
  };
}
