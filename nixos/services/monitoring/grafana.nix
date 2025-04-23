{ lib, config, ... }:

with lib;

let
  cfg = config.my.services.monitoring;

in
{
  config = mkIf cfg.enable {
    services.grafana = {
      enable = true;
      settings.server = {
        domain = "grafana.routing.rocks";
        http_addr = "127.0.0.1";
      };
    };
  };
}
