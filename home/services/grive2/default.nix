{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.services.grive2;

in {
  options = {
    services.grive2 = {
      enable = mkEnableOption "Grive2";

      driveDirectory = mkOption {
        type = types.str;
        default = "google-drive";
        description = "Directory name (has to be located in home directory)";
      };

      timerOnCalendar = mkOption {
        type = types.str;
        default = "*:0/5";
      };

      timerOnBootSec = mkOption {
        type = types.str;
        default = "3min";
      };

      timerOnUnitActiveSec = mkOption {
        type = types.str;
        default = "5min";
      };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      home.packages = with pkgs; [
        grive2
        inotify-tools
      ];

      home.file.".scripts/grive2/grive-sync.sh".source = ./grive-sync.sh;
    }
    {
      assertions = [
        (hm.assertions.assertPlatform "services.grive2" pkgs platforms.linux)
      ];

      systemd.user.services.grive = {
        Unit = {
          Description = "Google drive sync (main)";
          Requires = [ "grive-timer.timer" "grive-changes.service" ];
        };

        Service = {
          Type = "oneshot";
          ExecStart = "/run/current-system/sw/bin/true";
          RemainAfterExit = true;
        };
      };

      systemd.user.services.grive-timer = {
        Unit = {
          Description = "Google drive sync (executed by timer unit)";
          After = "network-online.target";
        };

        Service = {
          ExecStart = "/run/current-system/sw/bin/bash ${config.home.homeDirectory}/.scripts/grive2/grive-sync.sh sync ${cfg.driveDirectory}";
        };
      };

      systemd.user.services.grive-changes = {
        Unit = {
          Description = "Google drive sync (changed files)";
        };

        Service = {
          Type = "simple";
          ExecStart = "/run/current-system/sw/bin/bash ${config.home.homeDirectory}/.scripts/grive2/grive-sync.sh listen ${cfg.driveDirectory}";
          Restart = "always";
          RestartSec = 30;
        };
      };

      systemd.user.timers.grive-timer = {
        Unit = {
          Description = "Google drive sync (fixed intervals)";
        };

        Timer = {
          OnCalendar = cfg.timerOnCalendar;
          OnBootSec = cfg.timerOnBootSec;
          OnUnitActiveSec = cfg.timerOnUnitActiveSec;
          Unit = "grive-timer.service";
        };

        Install = { WantedBy = [ "timers.target" ]; };
      };
    }
  ]);
}
