{ lib, config, ... }:

with lib;

let
  cfg = config.my.services.jellyfin;
  version = "10.9.5";

in {
  options = {
    my.services.jellyfin = {
      enable = mkEnableOption "Jellyfin Media System";

      mediaDir = mkOption {
        description = "Local path to data directory containing media files";
        type = types.str;
        default = "/data/media";
      };

      publishServerUrl = mkOption {
        description = "Published URL";
        type = types.str;
        default = "media.routing.rocks";
      };
    };
  };

  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers = {
      jellyfin = {
        image = "lscr.io/linuxserver/jellyfin:${version}";

        autoStart = true;

        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "Europe/Berlin";
          JELLYFIN_PublishedServerUrl = cfg.publishServerUrl;
        };
        labels = {
          "io.containers.autoupdate" = "registry";
        };

        ports = [ "127.0.0.1:8096:8096" ];

        volumes = [
          "${cfg.mediaDir}:/media:ro"
          "jellyfin-config:/config:Z"
          "jellyfin-cache:/cache:Z"
        ];
      };
    };

    services.caddy.virtualHosts."media.routing.rocks".extraConfig = ''
      import private

      reverse_proxy * 127.0.0.1:8096
    '';

    services.restic.backups.jellyfin = {
      initialize = true;
      paths = [
        "/var/lib/containers/storage/volumes/jellyfin-config/_data/"
      ];
      pruneOpts = [
        "--keep-daily 7"
      ];
    };
  };
}
