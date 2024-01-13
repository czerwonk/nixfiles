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
        image = "lscr.io/linuxserver/jellyfin:latest";
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "Europe/Berlin";
          JELLYFIN_PublishedServerUrl = cfg.publishServerUrl;
        };
        autoStart = true;
        ports = [ "8096:8096" ];
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
  };
}
