{ lib, config, ... }:

with lib;

let
  cfg = config.my.services.pihole;
  version = "2024.02.0";

in {
  options = {
    my.services.pihole = {
      enable = mkEnableOption "pihole";

      dnsBindAddress = mkOption {
        description = "IP Address to bind DNS resolver to";
        type = types.str;
      };
    };
  };

  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers = {
      pihole = {
        image = "pihole/pihole:${version}";

        autoStart = true;

        environment = {
          TZ = "Europe/Berlin";
          DNSMASQ_USER = "root";
        };

        ports = [
          "127.0.0.1:8082:80"
          "${cfg.dnsBindAddress}:53:53/tcp"
          "${cfg.dnsBindAddress}:53:53/udp"
        ];

        volumes = [
          "pihole_config:/etc/pihole"
          "pihole_dnsmasq:/etc/dnsmasq.d"
        ];
      };
    };

    services.caddy.virtualHosts."pihole.routing.rocks".extraConfig = ''
      @blocked not remote_ip 2001:678:1e0::/48
      abort @blocked

      reverse_proxy * 127.0.0.1:8082
    '';

    services.restic.backups.pihole = {
      initialize = true;
      paths = [
        "/var/lib/containers/storage/volumes/pihole_config/_data/"
        "/var/lib/containers/storage/volumes/pihole_dnsmasq/_data/"
      ];
      pruneOpts = [
        "--keep-daily 7"
      ];
    };
  };
}
