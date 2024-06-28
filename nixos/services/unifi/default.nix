{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.my.services.unifi;
  version = "8.2.93";
  mongoInitJS = pkgs.writeText "init-mongo.js" ''
    db.getSiblingDB("unifi").createUser({user: "unifi", pwd: "${cfg.databasePassword}", roles: [{role: "dbOwner", db: "unifi"}]});
    db.getSiblingDB("unifi_stat").createUser({user: "unifi", pwd: "${cfg.databasePassword}", roles: [{role: "dbOwner", db: "unifi_stat"}]});
  '';

in {
  options = {
    my.services.unifi = {
      enable = mkEnableOption "Unifi Network Application";

      dataDir = mkOption {
        description = "Data directory";
        type = types.str;
        default = "/mnt/unifi";
      };

      databasePassword = mkOption {
        description = "Database password";
        type = types.str;
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
      wantedBy = [
        "podman-unifi-network-application.service"
        "podman-unifi-monogo.service"
      ];
      path = [ pkgs.podman ];
      script = ''
        podman network exists unifi || podman network create unifi
      '';
    };

    virtualisation.oci-containers.containers = {
      unifi-network-application = {
        image = "lscr.io/linuxserver/unifi-network-application:${version}";

        autoStart = true;
        extraOptions = [
          "--runtime=${pkgs.gvisor}/bin/runsc"
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
          MEM_LIMIT = "1024";
          MEM_STARTUP = "1024";
        };

        ports = [
          "8443:8443"
          "3478:3478/udp"
          "10001:10001/udp"
          "8080:8080"
          "1900:1900/udp"
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
        image = "docker.io/mongo:7.0.11";

        autoStart = true;
        extraOptions = [
          "--network=unifi"
        ];

        volumes = [
          "${cfg.dataDir}/db:/data/db"
          "${mongoInitJS}/init-mongo.js:/docker-entrypoint-initdb.d/init-mongo.js:ro"
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
