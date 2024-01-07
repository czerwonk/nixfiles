{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.services.custom.mastodon;
  backup = pkgs.writeShellScriptBin "mastodon-backup" (builtins.readFile ./backup.sh);
  cleanup = pkgs.writeShellScriptBin "mastodon-cleanup" (builtins.readFile ./cleanup.sh);

in {
  options = {
    services.custom.mastodon = {
      enable = mkEnableOption "Mastodon";
    };
  };

  config = mkIf cfg.enable {
    systemd.services.mastodon = {
      description = "Mastodon";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      path = [ pkgs.podman ];
      serviceConfig = {
        WorkingDirectory = "/opt/mastodon";
        Type = "simple";
        ExecStart = "${pkgs.podman-compose}/bin/podman-compose up -d";
        ExecStop = "${pkgs.podman-compose}/bin/podman-compose down";
        RemainAfterExit = true;
        Restart = "always";
        RestartSec = 60;
      };
    };

    systemd.timers = {
      mastodon-backup = {
        timerConfig = {
          Unit = "mastodon-backup.service";
          OnCalendar = "*-*-* 00:00:00";
        };
        wantedBy = [ "timers.target" ];
        partOf = [ "mastodon-backup.service" ];
      };
      mastodon-cleanup = {
        timerConfig = {
          Unit = "mastodon-cleanup.service";
          OnCalendar = "*-*-* 01:00:00";
        };
        wantedBy = [ "timers.target" ];
        partOf = [ "mastodon-cleanup.service" ];
      };
    };

    systemd.services = {
      mastodon-backup = {
        description = "Mastodon Backup";
        path = with pkgs; [
          podman
          podman-compose
          gzip
          gnutar
        ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${backup}/bin/mastodon-backup";
        };
      };
      mastodon-cleanup = {
        description = "Mastodon Clenup Tasks";
        path = with pkgs; [
          podman
          podman-compose
        ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${cleanup}/bin/mastodon-cleanup";
        };
      };
    };

    services.caddy.virtualHosts."routing.rocks".extraConfig = lib.mkAfter ''
      redir /.well-known/host-meta https://social.routing.rocks{uri}
      redir /.well-known/webfinger https://social.routing.rocks{uri}
    '';

    services.caddy.virtualHosts."social.routing.rocks".extraConfig = ''
      reverse_proxy * 127.0.0.1:3000

      encode gzip
    '';
  };
}
