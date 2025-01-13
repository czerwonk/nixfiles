{ lib, config, ... }:

with lib;

let
  cfg = config.my.services.kosync;

in {
  options = {
    my.services.kosync = {
      enable = mkEnableOption "Koreader Sync Server";
    };
  };

  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers = {
      kosync = {
        image = "koreader/kosync:latest";

        extraOptions = [
          "--runtime=${pkgs.gvisor}/bin/runsc"
        ];

        autoStart = true;

        environment = {
          TZ = "Europe/Berlin";
        };

        ports = [ "7200:7200" ];

        volumes = [
          "kosync-redis-data:/var/lib/redis"
        ];
      };
    };

    services.restic.backups.kosync = {
      initialize = true;
      paths = [
        "/var/lib/containers/storage/volumes/kosync-redis-data/_data/"
      ];
      pruneOpts = [
        "--keep-daily 7"
      ];
    };
  };
}
