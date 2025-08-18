{ lib, config, ... }:

with lib;

let
  cfg = config.my.services.monitoring;

in
{
  config = mkIf cfg.enable {
    services.caddy.virtualHosts."prometheus.routing.rocks".extraConfig = ''
      import private

      reverse_proxy * 127.0.0.1:${toString config.services.prometheus.port}

      encode gzip
    '';

    services.caddy.virtualHosts."grafana.routing.rocks".extraConfig = ''
      import private

      reverse_proxy * 127.0.0.1:${toString config.services.grafana.settings.server.http_port}

      encode gzip
    '';

    services.caddy.virtualHosts."alertmanager.routing.rocks".extraConfig = ''
      import private

      reverse_proxy * 127.0.0.1:${toString config.services.prometheus.alertmanager.port}

      encode gzip
    '';

    services.caddy.virtualHosts."otel.routing.rocks".extraConfig = ''
      import private

      reverse_proxy * h2c://127.0.0.1:4320

      encode gzip
    '';
  };
}
