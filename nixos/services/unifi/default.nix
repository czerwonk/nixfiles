{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

let
  cfg = config.my.services.unifi;
  version = "10.4.57";
  mongoInitSh = pkgs.writeText "init-mongo.sh" ''
    #!/bin/bash
    if which mongosh > /dev/null 2>&1; then
      mongo_init_bin='mongosh'
    else
      mongo_init_bin='mongo'
    fi
    "$mongo_init_bin" <<EOF
    use $MONGO_AUTHSOURCE
    db.auth("$MONGO_INITDB_ROOT_USERNAME", "$MONGO_INITDB_ROOT_PASSWORD")
    db.createUser({
      user: "$MONGO_USER",
      pwd: "$MONGO_PASS",
      roles: [
        { role: "clusterMonitor", db: "admin" },
        { role: "dbOwner", db: "$MONGO_DBNAME" },
        { role: "dbOwner", db: "unifi_stat" },
        { role: "dbOwner", db: "unifi_audit" },
        { role: "dbOwner", db: "unifi_restore" }
      ]
    })
    EOF
  '';

in
{
  options = {
    my.services.unifi = {
      enable = mkEnableOption "Unifi Network Application";

      dataDir = mkOption {
        description = "Data directory";
        type = types.str;
        default = "/var/lib/unifi";
      };

      databasePassword = mkOption {
        description = "Database user password";
        type = types.str;
      };

      databaseRootPassword = mkOption {
        description = "Database root user password";
        type = types.str;
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.services.podman-create-unifi-net = {
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

        ExecPaths = [ "/nix/store" ];
        NoExecPaths = [ "/" ];
      };
      wantedBy = [
        "podman-unifi-network-application.service"
        "podman-unifi-db.service"
      ];
      path = [ pkgs.podman ];
      script = ''
        podman network exists unifi || podman network create unifi
      '';
    };

    virtualisation.oci-containers.containers = {
      unifi-network-application = {
        image = "lscr.io/linuxserver/unifi-network-application:${version}";

        dependsOn = [
          "unifi-db"
        ];

        autoStart = true;
        extraOptions = [
          "--network=unifi"
        ];

        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "Europe/Berlin";
          MONGO_USER = "unifi";
          MONGO_PASS = cfg.databasePassword;
          MONGO_HOST = "unifi-db";
          MONGO_PORT = "27017";
          MONGO_DBNAME = "unifi";
          MONGO_AUTHSOURCE = "admin";
          MEM_LIMIT = "1024";
          MEM_STARTUP = "1024";
        };

        ports = [
          "8443:8443"
          "3478:3478/udp"
          "10001:10001/udp"
          "8080:8080"
          "8843:8843"
          "8880:8880"
          "6789:6789"
          "5514:5514/udp"
        ];

        volumes = [
          "${cfg.dataDir}/config:/config"
        ];
      };

      unifi-db = {
        image = "docker.io/mongo:7.0.37";

        environment = {
          MONGO_INITDB_ROOT_USERNAME = "root";
          MONGO_INITDB_ROOT_PASSWORD = cfg.databaseRootPassword;
          MONGO_USER = "unifi";
          MONGO_PASS = cfg.databasePassword;
          MONGO_DBNAME = "unifi";
          MONGO_AUTHSOURCE = "admin";
        };

        autoStart = true;
        extraOptions = [
          "--network=unifi"
        ];

        volumes = [
          "${cfg.dataDir}/db:/data/db"
          "${mongoInitSh}:/docker-entrypoint-initdb.d/init-mongo.sh:ro"
        ];
      };
    };

    services.caddy.virtualHosts."unifi.routing.rocks".extraConfig = ''
      import private

      reverse_proxy * 127.0.0.1:8443 {
        transport http {
          tls
          tls_insecure_skip_verify
        }
      }
    '';
  };
}
