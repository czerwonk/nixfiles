{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

let
  cfg = config.my.services.audiobookshelf;
  version = "2.26.2";

in
{
  options = {
    my.services.audiobookshelf = {
      enable = mkEnableOption "Audio Book Shelf";

      audiobookDir = mkOption {
        description = "Local path to data directory containing audio files";
        type = types.str;
        default = "/data/media/Audiobooks";
      };

      podcastDir = mkOption {
        description = "Local path to data directory containing podcast files";
        type = types.str;
        default = "/data/media/Podcasts";
      };
    };
  };

  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers = {
      audiobookshelf = {
        image = "ghcr.io/advplyr/audiobookshelf:${version}";

        autoStart = true;
        extraOptions = [
          "--runtime=${pkgs.gvisor}/bin/runsc"
        ];
        user = "1000";

        environment = {
          TZ = "Europe/Berlin";
          PORT = "13378";
          AUDIOBOOKSHELF_UID = "1000";
          AUDIOBOOKSHELF_GID = "1000";
        };

        ports = [ "127.0.0.1:13378:13378" ];

        volumes = [
          "${cfg.audiobookDir}:/audiobooks:ro"
          "${cfg.podcastDir}:/podcasts"
          "audiobookshelf_config:/config"
          "audiobookshelf_metadata:/metadata"
        ];
      };
    };

    services.caddy.virtualHosts."audiobooks.routing.rocks".extraConfig = ''
      import private

      reverse_proxy * 127.0.0.1:13378
    '';

    services.restic.backups.audiobookshelf = {
      initialize = true;
      paths = [
        "/var/lib/containers/storage/volumes/audiobookshelf_config"
        "/var/lib/containers/storage/volumes/audiobookshelf_metadata"
      ];
      pruneOpts = [
        "--keep-daily 7"
      ];
    };
  };
}
