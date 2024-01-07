{ lib, config, ... }:

with lib;

let
  cfg = config.services.custom.monitoring;

in {
  config = mkIf cfg.enable {
    services.prometheus.alertmanager = {
      enable = true;
      listenAddress = "127.0.0.1";
      webExternalUrl = "https://alertmanager.routing.rocks";
      configuration = {
        route = {
          group_by = [ "..." ];
          group_wait = "30s";
          receiver = "pagerduty";
        };
        receivers = [
          {
            name = "pagerduty";
            pagerduty_configs = [
              {
                routing_key = config.services.custom.monitoring.pagerdutyToken;
                send_resolved = true;
                severity = "{{ .GroupLabels.severity }}";
              }
            ];
          }
        ];
      };
    };
  };
}
