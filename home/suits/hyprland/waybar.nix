{ pkgs, config, ... }:

{
  programs.waybar = {
    enable = true;
    settings.mainBar = {
      height = 25;
      spacing = 5;
      modules-left = [ "hyprland/workspaces" ];
      modules-right = [
        "battery"
        "backlight"
        "pulseaudio"
        "bluetooth"
        "network"
        "keyboard-state"
        "clock"
      ];
      backlight = {
        device = "${config.suits.hyprland.backlightDevice}";
        format = "{percent}% {icon}";
        format-icons = [ "" "" ];
      };
      battery = {
        format = "{capacity}% {icon}";
        format-alt = "{time} {icon}";
        format-charging = "{capacity}% ";
        format-icons = [ "" "" "" "" "" ];
        format-plugged = "{capacity}% ";
      };
      bluetooth = {
          format = " {status}";
          format-disabled = "";
          interval = 30;
          on-click = "${pkgs.rofi-bluetooth}/bin/rofi-bluetooth";
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
        family = "ipv6";
        on-click-right = "${pkgs.networkmanager_dmenu}/bin/networkmanager_dmenu";
      };
      pulseaudio = {
        format = "{volume}% {icon} {format_source}";
        format-bluetooth = "{volume}% {icon} {format_source}";
        format-bluetooth-muted = " {icon} {format_source}";
        format-icons = {
          "default" = [ "" "" "" ];
          "headphone" = "";
        };
        format-muted = " {format_source}";
        format-source = "{volume}% ";
        format-source-muted = "";
        on-click = "${pkgs.rofi-pulse-select}/bin/rofi-pulse-select sink";
        on-click-right = "${pkgs.rofi-pulse-select}/bin/rofi-pulse-select source";
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

      #battery, #bluetooth, #backlight, #network, #pulseaudio #keyboard-state {
          margin:     0px 6px 0px 10px;
          min-width:  25px;
      }

      #backlight {
        color: #DCD7BA;
      }

      #battery {
        color: #76946A;
      }

      #battery.charging {
        color: #76946A;
      }

      #battery.warning:not(.charging) {
        color: #FF9E3B;
      }

      #pulseaudio {
        color: #DCA561;
      }

      #network {
        color: #658594;
      }

      #bluetooth {
        color: #A3D4D5;
      }
    '';
  };

  home.file.".config/networkmanager-dmenu/config.ini".text = ''
    [dmenu]
    dmenu_command = ${config.programs.rofi.package}/bin/rofi -dmenu
  '';
}
