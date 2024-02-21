{ pkgs, config, ... }:

{
  programs.waybar = {
    enable = true;
    settings.mainBar = {
      height = 26;
      spacing = 5;
      show-special = true;
      modules-left = [ 
        "hyprland/workspaces"
      ];
      modules-center = [
        "clock"
        "idle_inhibitor"
      ];
      modules-right = [
        "tray"
        "battery"
        "backlight"
        "pulseaudio"
        "bluetooth"
        "network"
        "group/group-power"
      ];
      backlight = {
        device = "${config.suits.hyprland.backlightDevice}";
        format = "{icon} {percent}%";
        format-icons = [ "" "" ];
      };
      battery = {
        format = "{icon} {capacity}%";
        format-alt = "{icon} {time}";
        format-charging = " {capacity}%";
        format-icons = [ "" "" "" "" "" ];
        format-plugged = " {capacity}%";
      };
      bluetooth = {
        format = " {status}";
        format-disabled = "";
        interval = 30;
        on-click = "${pkgs.rofi-bluetooth}/bin/rofi-bluetooth";
        on-click-right = "${pkgs.blueberry}/bin/blueberry";
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
          "urgent" = "";
          "1" = "";
          "2" = "";
          "3" = "";
          "4" = "✉";
          "5" = "";
        };
      };
      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          "activated" = "";
          "deactivated" = "";
        };
      };
      network = {
        format-alt = "{ifname}: {ipaddr}/{cidr}";
        format-disconnected = "⚠ disconnected";
        format-ethernet = " {ifname}";
        format-linked = " {ifname} (No IP)";
        format-wifi = " {essid} ({signalStrength}%)";
        tooltip-format = " {ifname} via {gwaddr}";
        family = "ipv6";
        on-click-right = "${pkgs.networkmanager_dmenu}/bin/networkmanager_dmenu";
      };
      tray = {
        spacing = 10;
      };
      pulseaudio = {
        format = "{icon} {volume}% {format_source}";
        format-muted = " {format_source}";
        format-bluetooth = "{icon} {volume}% {format_source}";
        format-bluetooth-muted = " {format_source}";
        format-source = " {volume}%";
        format-source-muted = "";
        format-icons = {
          "default" = [ "" "" "" ];
          "headphone" = "";
        };
        on-click = "${pkgs.rofi-pulse-select}/bin/rofi-pulse-select sink";
        on-click-right = "${pkgs.rofi-pulse-select}/bin/rofi-pulse-select source";
      };
      "group/group-power" = {
        orientation = "inherit";
        drawer = {
          transition-duration = 500;
          transition-left-to-right = false;
        };
        modules = [
          "custom/power"
          "custom/quit"
          "custom/lock"
          "custom/reboot"
        ];
      };

      "custom/quit" = {
        format = "󰗼";
        on-click = "hypr-logout";
        tooltip = false;
      };

      "custom/lock" = {
        format = "󰍁";
        on-click = "${config.programs.swaylock.package}/bin/swaylock -f";
        tooltip = false;
      };

      "custom/reboot" = {
        format = "󰜉";
        on-click = "hypr-reboot";
        tooltip = false;
      };

      "custom/power" = {
        format = "";
        on-click = "hypr-halt";
        tooltip = false;
      };
    };
    style = ''
      * {
        font-family: JetBrains Mono;
        font-size: 14px;
      }

      window#waybar {
        background-color: #16161D;
        opacity: 0.9;
        color: #C0A36E;
        transition-property: background-color;
        transition-duration: .5s;
      }

      #workspaces {
        padding-left: 5px;
        border-radius: 15;
        background-color: #1F1F28;
      }

      #workspaces button {
        margin: 1px 5px 1px 0;
        padding: 0 5px;
        background-color: #2A2A37;
        border-radius: 10;
        color: #C0A36E;
        min-width: 25px;
      }

      #workspaces button.visible {
        color: #658594;
      }

      #workspaces button.urgent {
        color: #C34043;
      }

      button {
        box-shadow: inset 0 -3px transparent;
        border: 1px;
        border-color: #ffffff;
        border-radius: 0;
      }

      #idle_inhibitor {
        margin: 1px 5px 1px 0;
        padding-left: 5px;
      }

      #custom-lock,
      #custom-power,
      #custom-quit,
      #custom-reboot,
      #group-group-power {
        margin: 1px 5px 1px 0;
        min-width: 15px;
        padding-right: 5px;
        border-radius: 10;
        background-color: #1F1F28;
      }

      #tray,
      #battery,
      #bluetooth,
      #backlight,
      #network,
      #pulseaudio {
        margin: 3px 5px 3px 0;
        min-width:  30px;
        border-radius: 10;
        background-color: #1F1F28;
        padding-left: 3px;
        padding-right: 3px;
      }

      #backlight {
        color: #DCD7BA;
      }

      #battery {
        color: #76946A;
      }

      #battery.warning:not(.charging) {
        color: #FF9E3B;
      }

      #pulseaudio {
        color: #DCA561;
      }

      #network {
        color: #98BB6C;
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
