{ lib, config, username, ... }:

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
        default = "/media";
      };
    };
  };

  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers = {
      jellyfin = {
        image = "docker.io/jellyfin/jellyfin:latest";
        autoStart = true;
        ports = [ "8096:8096" ];
        user = username;
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
