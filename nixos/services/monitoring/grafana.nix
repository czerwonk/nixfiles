{ lib, config, ... }:

with lib;

let
  cfg = config.services.custom.monitoring;

in {
  config = mkIf cfg.enable {
    services.grafana = {
      settings.server = {
        domain = "grafana.routing.rocks";
        http_addr = "127.0.0.1";
      };
    };
  };
}
