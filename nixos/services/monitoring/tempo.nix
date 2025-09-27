{ lib, config, ... }:

with lib;

let
  cfg = config.my.services.monitoring;
  dataDir = "/var/lib/tempo";

in
{
  config = mkIf cfg.enable {
    services.tempo = {
      enable = true;
      settings = {
        server = {
          http_listen_port = 3200;
        };

        ingester = {
          max_traces_per_user = 100;
          max_global_traces_per_user = 1000;
          trace_idle_period = "30s";
          max_trace_size_bytes = 1000000; # 1MB max trace size
        };

        distributor = {
          ring = {
            kvstore.store = "memberlist";
          };
        };

        querier = {
          max_concurrent_queries = 2;
          search = {
            default_result_limit = 10;
            max_result_limit = 50;
          };
        };

        storage.trace = {
          backend = "local";
          local.path = "${dataDir}/traces";
          wal.path = "${dataDir}/wal";

          pool = {
            max_workers = 2; # Reduced from 20
            queue_depth = 1000; # Reduced from 10000
          };

          block = {
            v2_index_downsample_bytes = 524288; # 512KB
            v2_index_page_size_bytes = 131072; # 128KB
            bloom_filter_false_positive = 0.05;
          };
        };

        compactor = {
          retention_duration = "24h"; # Adjust based on your needs
          ring = {
            kvstore.store = "memberlist";
          };
        };
      };
    };

    systemd.tmpfiles.rules = [
      "d ${dataDir} 0755 tempo tempo -"
      "d ${dataDir}/traces 0755 tempo tempo -"
      "d ${dataDir}/wal 0755 tempo tempo -"
    ];
  };
}
