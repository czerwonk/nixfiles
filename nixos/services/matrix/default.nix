{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.services.custom.matrix;
  backup = pkgs.writeShellScriptBin "matrix-backup" (builtins.readFile ./backup.sh);

in {
  options = {
    services.custom.matrix = {
      enable = mkEnableOption "Matrix";

      databasePassword = mkOption {
        type = types.str;
        description = "Password for the PostgreSQL database";
      };
    };
  };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [ 8448 ];

    systemd.services.podman-create-matrix-pod = {
      serviceConfig.Type = "oneshot";
      wantedBy = [ "podman-matrix-synapse.service" ];
      path = [ pkgs.podman ];
      script = ''
        podman pod exists matrix || podman pod create -n matrix -p '127.0.0.1:8008:8008'
      '';
    };

    virtualisation.oci-containers.containers = {
      matrix-synapse = {
        autoStart = true;
        extraOptions = [ "--pod=matrix" ];

        image = "matrixdotorg/synapse";

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
      };

      matrix-db = {
        autoStart = true;
        extraOptions = [ "--pod=matrix" ];

        image = "postgres";

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

      matrix-whatsapp = {
        autoStart = true;
        extraOptions = [ "--pod=matrix" ];

        image = "dock.mau.dev/mautrix/whatsapp";

        volumes = [
          "matrix_whatsapp_data:/data"
        ];

        dependsOn = [
          "matrix-synapse"
        ];
      };
    };

    systemd.timers = {
      matrix-backup = {
        timerConfig = {
          Unit = "matrix-backup.service";
          OnCalendar = "*-*-* 03:00:00";
        };
        wantedBy = [ "timers.target" ];
        partOf = [ "matrix-backup.service" ];
      };
    };

    systemd.services = {
      matrix-backup = {
        description = "Matrix Backup";
        path = with pkgs; [
          podman
          podman-compose
          gzip
          gnutar
        ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${backup}/bin/matrix-backup";
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
      handle /.well-known/matrix/server {
        import matrix-well-known-header
        respond `{"m.server":"matrix.routing.rocks:443"}`
      }

      handle /.well-known/matrix/client {
        import matrix-well-known-header
        respond `{"m.homeserver":{"base_url":"https://matrix.routing.rocks"},"m.identity_server":{"base_url":"https://vector.im"}}`
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

    services.caddy.virtualHosts."routing.rocks:8448".extraConfig = ''
      reverse_proxy http://127.0.0.1:8008
    '';
  };
}
