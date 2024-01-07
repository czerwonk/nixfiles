{ lib, config, ... }:

with lib;

let
  cfg = config.services.custom.monitoring;

in {
  config = mkIf cfg.enable {
    services.prometheus = {
      listenAddress = "127.0.0.1";
      alertmanagers = [
        {
          scheme = "http";
          static_configs = [
            {
              targets = [
                "127.0.0.1:${toString config.services.prometheus.alertmanager.port}"
              ];
            }
          ];
        }
      ];
      scrapeConfigs = [
        {
          job_name = "node";
          static_configs = [{
            targets = [ 
              "bb1.dus.routing.rocks:${toString config.services.prometheus.exporters.node.port}"
              "bb2.dus.routing.rocks:${toString config.services.prometheus.exporters.node.port}"
            ];
          }];
          relabel_configs = [
            {
              source_labels = [ "__address__" ];
              regex = "^(.*)\\.routing\\.rocks:\\d+$";
              target_label = "instance";
              replacement = "$1";
              action = "replace";
            }
          ];
        }
        {
          job_name = "bird";
          static_configs = [{
            targets = [ 
              "bb1.dus.routing.rocks:${toString config.services.prometheus.exporters.bird.port}"
              "bb2.dus.routing.rocks:${toString config.services.prometheus.exporters.bird.port}"
            ];
          }];
          relabel_configs = [
            {
              source_labels = [ "__address__" ];
              regex = "^(.*)\\.routing\\.rocks:\\d+$";
              target_label = "instance";
              replacement = "$1";
              action = "replace";
            }
          ];
        }
        {
          job_name = "blackbox_https";
          metrics_path = "/probe";
          params = {
            module = [ "http_2xx" ];
          };
          static_configs = [{
            targets = [
              "social.routing.rocks"
              "nextcloud.routing.rocks/login"
              "matrix.routing.rocks/_matrix/client/versions"
            ];
          }];
          relabel_configs = [
            {
              source_labels = [ "__address__" ];
              target_label = "__param_target";
              replacement = "https://$1";
            }
            {
              source_labels = [ "__address__" ];
              regex = "^(.*)(/.*)?";
              target_label = "instance";
            }
            {
              target_label = "__address__";
              replacement = "127.0.0.1:9115";
            }
          ];
        }
      ];
      rules = [
        (builtins.readFile ./prometheus.rules.yml)
      ];
    };
  };
}
