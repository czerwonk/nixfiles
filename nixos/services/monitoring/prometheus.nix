{ lib, config, ... }:

with lib;

let
  cfg = config.my.services.monitoring;

in
{
  config = mkIf cfg.enable {
    services.prometheus = {
      enable = true;
      listenAddress = "127.0.0.1";
      pushgateway.enable = true;
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
          static_configs = [
            {
              targets = [
                "bb1.dus.routing.rocks:${toString config.services.prometheus.exporters.node.port}"
                "bb2.dus.routing.rocks:${toString config.services.prometheus.exporters.node.port}"
                "home1.ess.routing.rocks:${toString config.services.prometheus.exporters.node.port}"
                "home2.ess.routing.rocks:${toString config.services.prometheus.exporters.node.port}"
                "backup1.wup.routing.rocks:${toString config.services.prometheus.exporters.node.port}"
              ];
            }
          ];
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
          static_configs = [
            {
              targets = [
                "bb1.dus.routing.rocks:${toString config.services.prometheus.exporters.bird.port}"
                "bb2.dus.routing.rocks:${toString config.services.prometheus.exporters.bird.port}"
                "backup1.wup.routing.rocks:${toString config.services.prometheus.exporters.bird.port}"
              ];
            }
          ];
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
          job_name = "zfs";
          static_configs = [
            {
              targets = [
                "bb1.dus.routing.rocks:${toString config.services.prometheus.exporters.zfs.port}"
                "bb2.dus.routing.rocks:${toString config.services.prometheus.exporters.zfs.port}"
                "home1.ess.routing.rocks:${toString config.services.prometheus.exporters.zfs.port}"
                "home2.ess.routing.rocks:${toString config.services.prometheus.exporters.zfs.port}"
                "backup1.wup.routing.rocks:${toString config.services.prometheus.exporters.zfs.port}"
              ];
            }
          ];
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
          job_name = "crowdsec";
          static_configs = [
            {
              targets = [
                "bb1.dus.routing.rocks:6060"
                "bb2.dus.routing.rocks:6060"
                "127.0.0.1:6060"
              ];
            }
          ];
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
          static_configs = [
            {
              targets = [
                "audiobooks.routing.rocks"
                "books.routing.rocks/login"
                "code.routing.rocks"
                "home.routing.rocks"
                "matrix.routing.rocks/_matrix/client/versions"
                "media.routing.rocks/web/index.html"
                "nextcloud.routing.rocks/login"
                "ntfy.routing.rocks"
                "photos.routing.rocks"
                "rss.routing.rocks"
                "social.routing.rocks"
                "unifi.routing.rocks/manage/account/login"
                "vaultwarden.routing.rocks"
              ];
            }
          ];
          relabel_configs = [
            {
              source_labels = [ "__address__" ];
              target_label = "__param_target";
              replacement = "https://$1";
            }
            {
              source_labels = [ "__address__" ];
              regex = "^([^/]+)(/.*)?";
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
