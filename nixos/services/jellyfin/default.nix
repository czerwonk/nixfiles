{ lib, config, ... }:

with lib;

let
  cfg = config.services.custom.jellyfin;

in {
  options = {
    services.custom.jellyfin = {
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
        image = "lscr.io/linuxserver/jellyfin";
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "Europe/Berlin";
          JELLYFIN_PublishedServerUrl = cfg.publishServerUrl;
        };
        autoStart = true;
        ports = [ "127.0.0.1:8096:8096" ];
        labels = {
          "io.containers.autoupdate" = "registry";
        };
        volumes = [
          "${cfg.mediaDir}:/media:ro"
          "jellyfin-config:/config:Z"
          "jellyfin-cache:/cache:Z"
        ];
      };
    };

    services.caddy.virtualHosts."media.routing.rocks".extraConfig = ''
      @blocked not remote_ip 2001:678:1e0::/48
      abort @blocked

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
