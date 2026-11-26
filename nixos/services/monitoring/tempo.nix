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

        # Tempo 3.x replaced the ingester with the live-store; in monolithic
        # mode it needs no Kafka. Paths default to /var/tempo, outside our state dir.
        live_store = {
          max_trace_idle = "30s";
          max_block_duration = "1m0s";
          max_block_bytes = 100000000;
          wal.path = "${dataDir}/live-store/traces";
          shutdown_marker_dir = "${dataDir}/live-store/shutdown-marker";
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
      "d ${dataDir}/live-store 0755 tempo tempo -"
    ];
  };
}
