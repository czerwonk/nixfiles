{ lib, config, ... }:

with lib;

let
  cfg = config.services.custom.monitoring;

in {
  config = mkIf cfg.enable {
    services.caddy.virtualHosts."prometheus.routing.rocks".extraConfig = ''
      @blocked not remote_ip 2001:678:1e0::/48
      abort @blocked

      reverse_proxy * 127.0.0.1:${toString config.services.prometheus.port}

      encode gzip
    '';

    services.caddy.virtualHosts."grafana.routing.rocks".extraConfig = ''
      @blocked not remote_ip 2001:678:1e0::/48
      abort @blocked

      reverse_proxy * 127.0.0.1:${toString config.services.grafana.settings.server.http_port}

      encode gzip
    '';

    services.caddy.virtualHosts."alertmanager.routing.rocks".extraConfig = ''
      @blocked not remote_ip 2001:678:1e0::/48
      abort @blocked

      reverse_proxy * 127.0.0.1:${toString config.services.prometheus.alertmanager.port}

      encode gzip
    '';
  };
}
