{ lib, config, ... }:

with lib;

let
  cfg = config.my.services.monitoring;

in {
  imports = [
    ./prometheus.nix
    ./grafana.nix
    ./alertmanager.nix
    ./caddy.nix
  ];

  options = {
    my.services.monitoring = {
      enable = mkEnableOption "Prometheus Monitoring Stack";

      pagerdutyToken = mkOption {
        type = types.str;
        description = mdDoc "Pagerduty Events API Token";
      };
    };
  };

  config = mkIf cfg.enable {
    security.allowUserNamespaces = true;

    services.prometheus.exporters.blackbox = {
      enable = true;
      configFile = ./blackbox.config.yml;
    };
  };
}
