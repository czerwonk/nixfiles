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
          trace_idle_period = "30s";
          max_block_duration = "1m0s";
          max_block_bytes = 100000000;
        };

        querier = {
          max_concurrent_queries = 5;
        };

        storage.trace = {
          backend = "local";
          local.path = "${dataDir}/traces";
          wal.path = "${dataDir}/wal";

          pool = {
            max_workers = 10;
            queue_depth = 2000;
          };

          block = {
            bloom_filter_false_positive = 0.05;
            v2_index_downsample_bytes = 524288;
            v2_index_page_size_bytes = 128000;
          };
        };

        overrides = {
          defaults = {
            ingestion = {
              max_traces_per_user = 1000;
            };
            global = {
              max_bytes_per_trace = 1000000;
            };
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
