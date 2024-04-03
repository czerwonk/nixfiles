{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.my.services.matrix;
  version = "v1.104.0";
  backup = pkgs.writeShellScriptBin "matrix-db-backup" (builtins.readFile ./db-backup.sh);

in {
  options = {
    my.services.matrix = {
      enable = mkEnableOption "Matrix";

      databasePassword = mkOption {
        type = types.str;
        description = "Password for the PostgreSQL database";
      };

      syncv3Secret = mkOption {
        type = types.str;
        description = "Secret for the sliding sync proxy";
      };
    };
  };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [ 8448 ];

    systemd.services.podman-create-matrix-net = {
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
      wantedBy = [ "podman-matrix-synapse.service" ];
      path = [ pkgs.podman ];
      script = ''
        podman network exists matrix || podman network create matrix
      '';
    };

    virtualisation.oci-containers.containers = {
      matrix-synapse = {
        image = "matrixdotorg/synapse:${version}";

        autoStart = true;
        extraOptions = [
          "--runtime=${pkgs.gvisor}/bin/runsc"
          "--network=matrix"
        ];
        user = "991:991";

        environment = {
          SYNAPSE_SERVER_NAME = "matrix.routing.rocks";
          SYNAPSE_REPORT_STATS = "no";
        };

        volumes = [
          "matrix_homeserver_data:/data"
        ];

        dependsOn = [
          "matrix-db"
        ];

        ports = [
          "127.0.0.1:8008:8008"
        ];
      };

      matrix-db = {
        image = "postgres";

        autoStart = true;
        extraOptions = [
          "--network=matrix"
        ];

        environment = {
          POSTGRES_PASSWORD = cfg.databasePassword;
          POSTGRES_USER = "synapse";
          POSTGRES_DB = "synapse";
          POSTGRES_INITDB_ARGS = "--encoding='UTF8' --lc-collate='C' --lc-ctype='C'";
        };

        volumes = [
          "matrix_db_data:/var/lib/postgresql/data" 
        ];
      };

      matrix-sliding-sync = {
        image = "ghcr.io/matrix-org/sliding-sync";

        autoStart = true;
        extraOptions = [
          "--runtime=${pkgs.gvisor}/bin/runsc"
          "--network=matrix"
        ];
        user = "991:991";

        environment = {
          SYNCV3_SERVER = "https://matrix.routing.rocks";
          SYNCV3_DB = "user=synapse dbname=syncv3 sslmode=disable host=matrix-db password='${cfg.databasePassword}'";
          SYNCV3_SECRET = cfg.syncv3Secret;
        };

        dependsOn = [
          "matrix-synapse"
        ];

        ports = [
          "127.0.0.1:8009:8008"
        ];
      };

      matrix-whatsapp = {
        image = "dock.mau.dev/mautrix/whatsapp";
        cmd = [ "/usr/bin/mautrix-whatsapp" ];
        workdir = "/data";

        autoStart = true;
        extraOptions = [
          "--runtime=${pkgs.gvisor}/bin/runsc"
          "--network=matrix"
        ];
        user = "1337:1337";

        volumes = [
          "matrix_whatsapp_data:/data"
        ];

        dependsOn = [
          "matrix-synapse"
        ];
      };

      matrix-slack = {
        image = "dock.mau.dev/mautrix/slack";
        cmd = [ "/usr/bin/mautrix-slack" ];
        workdir = "/data";

        autoStart = true;
        extraOptions = [
          "--runtime=${pkgs.gvisor}/bin/runsc"
          "--network=matrix"
        ];
        user = "1337:1337";

        volumes = [
          "matrix_slack_data:/data"
        ];

        dependsOn = [
          "matrix-synapse"
        ];
      };
    };

    systemd.timers = {
      matrix-db-backup = {
        timerConfig = {
          Unit = "matrix-db-backup.service";
          OnCalendar = "*-*-* 00:00:00";
        };
        wantedBy = [ "timers.target" ];
        partOf = [ "matrix-db-backup.service" ];
      };
    };

    systemd.services = {
      matrix-db-backup = {
        description = "Matrix Database Backup";
        path = with pkgs; [
          podman
          podman-compose
          gzip
        ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${backup}/bin/matrix-db-backup";

          ProtectSystem = "strict";
          ProtectHostname = true;
          ProtectClock = true;
          ProtectControlGroups = true;
          ProtectKernelTunables = true;
          ProtectKernelModules = true;
          PrivateDevices = true;

          ReadWritePaths = [
            "/data/backup"
            "/var/lib/containers/storage"
          ];

          ExecPaths = ["/nix/store"];
          NoExecPaths = ["/"];
        };
      };
    };

    services.caddy.extraConfig = lib.mkAfter ''
      (matrix-well-known-header) {
        header Access-Control-Allow-Origin "*"
        header Access-Control-Allow-Methods "GET, POST, PUT, DELETE, OPTIONS"
        header Access-Control-Allow-Headers "Origin, X-Requested-With, Content-Type, Accept, Authorization"
        header Content-Type "application/json"
      }
    '';

    services.caddy.virtualHosts."routing.rocks".extraConfig = lib.mkAfter ''
      import common

      handle /.well-known/matrix/server {
        import matrix-well-known-header
        respond `{"m.server":"matrix.routing.rocks:443"}`
      }

      handle /.well-known/matrix/client {
        import matrix-well-known-header
        respond `{
          "m.homeserver": {"base_url": "https://matrix.routing.rocks"},
          "m.identity_server": {"base_url": "https://vector.im"},
          "org.matrix.msc3575.proxy": {"url": "https://syncv3.matrix.routing.rocks"}
        }`
      }
    '';

    services.caddy.virtualHosts."matrix.routing.rocks".extraConfig = ''
      reverse_proxy /_matrix/* 127.0.0.1:8008
      reverse_proxy /_synapse/client/* 127.0.0.1:8008

      header {
        X-Content-Type-Options nosniff
        Referrer-Policy  strict-origin-when-cross-origin
        Strict-Transport-Security "max-age=63072000; includeSubDomains;"
        Permissions-Policy "accelerometer=(), camera=(), geolocation=(), gyroscope=(), magnetometer=(), microphone=(), payment=(), usb=(), interest-cohort=()"
        X-Frame-Options SAMEORIGIN
        X-XSS-Protection 1
        X-Robots-Tag none
        -server
      }
    '';

    services.caddy.virtualHosts."syncv3.matrix.routing.rocks".extraConfig = ''
      reverse_proxy http://127.0.0.1:8009
    '';

    services.caddy.virtualHosts."routing.rocks:8448".extraConfig = ''
      reverse_proxy http://127.0.0.1:8008
    '';

    services.restic.backups.matrix = {
      initialize = true;
      paths = [
        "/var/lib/containers/storage/volumes/matrix_homeserver_data/_data"
        "/var/lib/containers/storage/volumes/matrix_whatsapp_data/_data"
        "/var/lib/containers/storage/volumes/matrix_slack_data/_data"
        "/data/backup/matrix"
      ];
      pruneOpts = [
        "--keep-daily 7"
      ];
    };
  };
}
