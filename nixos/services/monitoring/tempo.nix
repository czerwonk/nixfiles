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

        storage.trace = {
          backend = "local";
          local.path = "${dataDir}/traces";
          wal.path = "${dataDir}/wal";
          pool = {
            max_workers = 20;
            queue_depth = 10000;
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
