{ lib, config, ... }:

with lib;

let
  cfg = config.my.services.monitoring;
  dataDir = "/var/lib/loki";

in
{
  config = mkIf cfg.enable {
    services.loki = {
      enable = true;
      dataDir = dataDir;
      configuration = {
        auth_enabled = false;

        server = {
          http_listen_port = 3100;
        };

        common = {
          instance_addr = "127.0.0.1";
          path_prefix = "/loki";
          storage = {
            filesystem = {
              chunks_directory = "${dataDir}/chunks";
              rules_directory = "${dataDir}/rules";
            };
          };
          replication_factor = 1;
          ring.kvstore.store = "inmemory";
        };

        query_range = {
          results_cache = {
            cache = {
              embedded_cache = {
                enabled = true;
                max_size_mb = 100;
              };
            };
          };
        };

        limits_config.metric_aggregation_enabled = true;

        schema_config = {
          configs = [
            {
              from = "2020-10-24";
              store = "tsdb";
              object_store = "filesystem";
              schema = "v13";
              index = {
                prefix = "index_";
                period = "24h";
              };
            }
          ];
        };

        pattern_ingester = {
          enabled = true;
          metric_aggregation = {
            loki_address = "localhost:3100";
          };
        };

        ruler.alertmanager_url = "http://localhost:9093";

        frontend.encoding = "protobuf";
      };
    };
  };
}
