{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.my.services.immich;
  version = "v1.120.1";
  backup = pkgs.writeShellScriptBin "immich-backup" (builtins.readFile ./backup.sh);
  databaseName = "immich";
  databaseUsername = "postgres";
  environment = {
    IMMICH_VERSION = "release";
    DB_HOSTNAME = "immich_postgres";
    DB_USERNAME = databaseUsername;
    DB_DATABASE_NAME = databaseName;
    DB_PASSWORD = cfg.databasePassword;
    REDIS_HOSTNAME = "immich_redis";
    TZ = "Europe/Berlin";
  };

in {
  options = {
    my.services.immich = {
      enable = mkEnableOption "Immich - High performance self-hosted photo and video backup solution";

      dataDir = mkOption {
        type = types.str;
        description = "Directory to store the uploaded photos";
        default = "/data/photos";
      };

      databasePassword = mkOption {
        type = types.str;
        description = "Password for the PostgreSQL database";
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.services.podman-create-immmich-net = {
      serviceConfig = {
        Type = "oneshot";

        ProtectSystem = "strict";
        ProtectHostname = true;
        ProtectClock = true;
        ProtectControlGroups = true;
        ProtectKernelTunables = true;
        ProtectKernelModules = true;

        ReadWritePaths = [
          "/etc/containers"
          "/var/lib/containers"
        ];

        ExecPaths = ["/nix/store"];
        NoExecPaths = ["/"];
      };
      wantedBy = [ "podman-immich_server.service" ];
      path = [ pkgs.podman ];
      script = ''
        podman network exists immich || podman network create immich
      '';
    };

    virtualisation.oci-containers.containers = {
      immich_server = {
        image = "ghcr.io/immich-app/immich-server:${version}";

        autoStart = true;
        extraOptions = [
          "--runtime=${pkgs.gvisor}/bin/runsc"
          "--network=immich"
        ];
        user = "1000";

        environment = environment;

        volumes = [
          "${cfg.dataDir}:/usr/src/app/upload" 
        ];

        ports = [ "127.0.0.1:3001:2283" ];

        dependsOn = [
          "immich_postgres"
          "immich_redis"
        ];
      };

      immich_redis = {
        image = "redis:6.2-alpine@sha256:c5a607fb6e1bb15d32bbcf14db22787d19e428d59e31a5da67511b49bb0f1ccc";

        autoStart = true;
        extraOptions = [
          "--network=immich"
        ];

        environment = {
          TZ = "Europe/Berlin";
        };
      };

      immich_postgres = {
        image = "tensorchord/pgvecto-rs:pg14-v0.2.0@sha256:90724186f0a3517cf6914295b5ab410db9ce23190a2d9d0b9dd6463e3fa298f0";

        autoStart = true;
        extraOptions = [
          "--network=immich"
        ];

        environment = {
          POSTGRES_PASSWORD = cfg.databasePassword;
          POSTGRES_USER = databaseUsername;
          POSTGRES_DB = databaseName;
        };

        volumes = [
          "immich_pgdata:/var/lib/postgresql/data"
        ];
      };
    };

    systemd.timers = {
      immich-backup = {
        timerConfig = {
          Unit = "immich-backup.service";
          OnCalendar = "*-*-* 03:00:00";
        };
        wantedBy = [ "timers.target" ];
        partOf = [ "immich-backup.service" ];
      };
    };

    systemd.services = {
      immich-backup = {
        description = "Immich Backup";
        path = with pkgs; [
          podman
          gzip
          gnutar
        ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${backup}/bin/immich-backup";

          ProtectSystem = "strict";
          ProtectHostname = true;
          ProtectClock = true;
          ProtectControlGroups = true;
          ProtectKernelTunables = true;
          ProtectKernelModules = true;
          PrivateDevices = true;

          ReadWritePaths = [
            "/mnt/backup"
            "/var/lib/containers/storage"
          ];

          ExecPaths = ["/nix/store"];
          NoExecPaths = ["/"];
        };
      };
    };

    services.caddy.virtualHosts."photos.routing.rocks".extraConfig = ''
      import private

      reverse_proxy * 127.0.0.1:3001
    '';
  };
}
