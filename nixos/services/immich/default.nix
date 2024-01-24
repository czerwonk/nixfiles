{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.services.custom.immich;
  backup = pkgs.writeShellScriptBin "immich-backup" (builtins.readFile ./backup.sh);
  databaseName = "immich";
  databaseUsername = "postgres";
  databasePassword = "nbAR2GV292G5QvvW";
  environment = {
    IMMICH_VERSION = "release";
    DB_HOSTNAME = "immich_postgres";
    DB_USERNAME = databaseUsername;
    DB_DATABASE_NAME = databaseName;
    DB_PASSWORD = databasePassword;
    REDIS_HOSTNAME = "immich_redis";
    TZ = "Europe/Berlin";
  };

in {
  options = {
    services.custom.immich = {
      enable = mkEnableOption "Immich - High performance self-hosted photo and video backup solution";

      dataDir = mkOption {
        type = types.str;
        description = "Directory to store the uploaded photos";
        default = "/data/photos";
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.services.podman-create-immmich-pod = {
      serviceConfig.Type = "oneshot";
      wantedBy = [ "podman-immich-server.service" ];
      path = [ pkgs.podman ];
      script = ''
        podman pod exists immich || podman pod create -n immich -p '127.0.0.1:3001:3001'
      '';
    };

    virtualisation.oci-containers.containers = {
      immich_server = {
        autoStart = true;
        extraOptions = [ "--pod=immich" ];
        user = "1000";

        image = "ghcr.io/immich-app/immich-server:release";
        entrypoint = "/usr/src/app/start.sh";
        cmd = [ "immich" ];

        environment = environment;

        volumes = [
          "${cfg.dataDir}:/usr/src/app/upload" 
        ];

        dependsOn = [
          "immich_postgres"
          "immich_redis"
        ];
      };

      immich_microservices = {
        autoStart = true;
        extraOptions = [ "--pod=immich" ];
        user = "1000";

        image = "ghcr.io/immich-app/immich-server:release";
        entrypoint = "/usr/src/app/start.sh";
        cmd = [ "microservices" ];

        environment = environment;

        volumes = [
          "${cfg.dataDir}:/usr/src/app/upload" 
        ];

        dependsOn = [
          "immich_postgres"
          "immich_redis"
        ];
      };

      immich_machine_learning = {
        autoStart = true;
        extraOptions = [ "--pod=immich" ];
        user = "1000";

        image = "ghcr.io/immich-app/immich-machine-learning:release";

        environment = environment;

        volumes = [
          "model-cache:/cache" 
        ];
      };

      immich_redis = {
        autoStart = true;
        extraOptions = [ "--pod=immich" ];

        image = "redis:6.2-alpine@sha256:c5a607fb6e1bb15d32bbcf14db22787d19e428d59e31a5da67511b49bb0f1ccc";

        environment = {
          TZ = "Europe/Berlin";
        };
      };

      immich_postgres = {
        autoStart = true;
        extraOptions = [ "--pod=immich" ];

        image = "tensorchord/pgvecto-rs:pg14-v0.1.11@sha256:0335a1a22f8c5dd1b697f14f079934f5152eaaa216c09b61e293be285491f8ee";

        environment = {
          POSTGRES_PASSWORD = databasePassword;
          POSTGRES_USER = databaseUsername;
          POSTGRES_DB = databaseName;
        };

        volumes = [
          "pgdata:/var/lib/postgresql/data" 
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
        };
      };
    };

    services.caddy.virtualHosts."photos.routing.rocks".extraConfig = ''
      @blocked not remote_ip 2001:678:1e0::/48
      abort @blocked

      reverse_proxy * 127.0.0.1:3001
    '';
  };
}
