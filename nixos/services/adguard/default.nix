{ lib, config, ... }:

with lib;

let
  cfg = config.my.services.adguard;
  version = "0.107.45";

in {
  options = {
    my.services.adguard = {
      enable = mkEnableOption "adguard";

      dnsBindAddress = mkOption {
        description = "IP Address to bind DNS resolver to";
        type = types.str;
      };
    };
  };

  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers = {
      adguard = {
        image = "adguard/adguardhome:v${version}";

        autoStart = true;

        environment = {
          TZ = "Europe/Berlin";
        };

        ports = [
          "127.0.0.1:8082:80"
          "${cfg.dnsBindAddress}:53:53/tcp"
          "${cfg.dnsBindAddress}:53:53/udp"
        ];

        volumes = [
          "adguard_config:/opt/adguardhome/conf"
          "adguard_work:/opt/adguardhome/work"
        ];
      };
    };

    services.caddy.virtualHosts."adguard.routing.rocks".extraConfig = ''
      import private

      reverse_proxy * 127.0.0.1:8082
    '';

    services.restic.backups.adguard = {
      initialize = true;
      paths = [
        "/var/lib/containers/storage/volumes/adguard_config/_data/"
        "/var/lib/containers/storage/volumes/adguard_work/_data/"
      ];
      pruneOpts = [
        "--keep-daily 7"
      ];
    };
  };
}
