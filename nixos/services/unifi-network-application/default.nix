{ lib, config, ... }:

with lib;

let
  cfg = config.services.custom.unifi;

in {
  options = {
    services.custom.unifi = {
      enable = mkEnableOption "";
    };
  };

  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers = {
      unifi = {
        image = "lscr.io/linuxserver/unifi-network-application:latest";
        environment = {
          PUID = "65534";
          PGID = "65534";
          TZ = "Europe/Berlin";
          MONGO_USER = "unifi";
          MONGO_PASS = "7vEJD232NnC6Pd";
          MONGO_HOST = "unifi-db";
          MONGO_PORT = "27017";
          MONGO_DBNAME = "unifi";
        };
        autoStart = true;
        ports = [
          "8443:8443"
          "3478:3478/udp"
          "10001:10001/udp"
          "8080:8080"
        ];
        volumes = [
          "unifi-config:/config"
        ];
        dependsOn = [
          "unifi-db"
        ];
      };
      unifi-db = {
        image = "docker.io/mongo:4.4";
        environment = {
          TZ = "Europe/Berlin";
        };
        autoStart = true;
        volumes = [
          "unifi-db:/data/db"
        ];
      };
    };
  };
}

