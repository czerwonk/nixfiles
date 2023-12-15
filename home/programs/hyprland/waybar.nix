{
  programs.waybar = {
    enable = true;
    settings.mainBar = {
      height = 25;
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
        format = "{:%A %d %B %Y %H:%M}";
        locale = "en_US.UTF-8";
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
    style = ''
      * {
        font-family: JetBrains Mono;
        font-size: 14px;
      }

      window#waybar {
        background-color: #2A2A37;
        opacity: 0.9;
        border-bottom: 3px solid rgba(100, 114, 125, 0.5);
        color: #C0A36E;
        transition-property: background-color;
        transition-duration: .5s;
      }

      #workspaces {
        margin-left: 0;
      }

      #workspaces button {
        padding: 0 5px;
        background-color: transparent;
        color: #C0A36E;
      }

      #workspaces button.focused {
        background-color: #658594;
        box-shadow: inset 0 -3px #ffffff;
      }

      #workspaces button.urgent {
        background-color: #C34043;
      }

      button {
        box-shadow: inset 0 -3px transparent;
        border: 1px;
        border-color: #ffffff;
        border-radius: 0;
      }

      #battery, #network, #pulseaudio #keyboard-state {
          margin:     0px 6px 0px 10px;
          min-width:  25px;
      }

      #battery {
        color: #76946A;
      }

      #battery.charging {
        color: #76946A;
      }

      #battery.warning:not(.charging) {
        color: #FCCE7B;
      }

      #pulseaudio {
        color: #FF9E3B;
      }

      #network {
        color: #658594;
      }

      #clock {
        margin-right: 0;
      }
    '';
  };
}
