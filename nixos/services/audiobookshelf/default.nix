{ lib, config, ... }:

with lib;

let
  cfg = config.services.custom.audiobookshelf;

in {
  options = {
    services.custom.audiobookshelf = {
      enable = mkEnableOption "Audio Book Shelf";

      audiobookDir = mkOption {
        description = "Local path to data directory containing audio files";
        type = types.str;
        default = "/data/media/Audiobooks";
      };
    };
  };

  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers = {
      audiobookshelf = {
        image = "ghcr.io/advplyr/audiobookshelf";
        user = "1000";
        environment = {
          TZ = "Europe/Berlin";
          PORT = "13378";
          AUDIOBOOKSHELF_UID = "1000";
          AUDIOBOOKSHELF_GID = "1000";
        };
        autoStart = true;
        ports = [ "127.0.0.1:13378:13378" ];
        volumes = [
          "${cfg.audiobookDir}:/audiobooks:ro"
          "audiobookshelf_config:/config"
          "audiobookshelf_metadata:/metadata"
        ];
      };
    };

    services.caddy.virtualHosts."audiobooks.routing.rocks".extraConfig = ''
      @blocked not remote_ip 2001:678:1e0::/48
      abort @blocked

      reverse_proxy * 127.0.0.1:13378
    '';
  };
}
