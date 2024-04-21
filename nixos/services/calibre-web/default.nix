{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.my.services.calibre-web;
  version = "0.6.21-ls264";

in {
  options = {
    my.services.calibre-web = {
      enable = mkEnableOption "Calibre Web";

      libraryDir = mkOption {
        description = "Local path to data directory containing book files";
        type = types.str;
        default = "/data/media/Books";
      };
    };
  };

  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers = {
      calibre-web = {
        image = "lscr.io/linuxserver/calibre-web:${version}";

        autoStart = true;
        extraOptions = [
          "--runtime=${pkgs.gvisor}/bin/runsc"
        ];

        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "Europe/Berlin";
        };

        ports = [ "127.0.0.1:8083:8083" ];

        volumes = [
          "${cfg.libraryDir}:/books:ro"
          "calibre_config:/config"
        ];
      };
    };

    services.caddy.virtualHosts."books.routing.rocks".extraConfig = ''
      import private

      reverse_proxy * 127.0.0.1:8083
    '';

    services.restic.backups.calibre-web = {
      initialize = true;
      paths = [
        "/var/lib/containers/storage/volumes/calibre_config"
      ];
      pruneOpts = [
        "--keep-daily 7"
      ];
    };
  };
}
