{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.my.services.calibre-web;
  version = "0.6.24";

in {
  options = {
    my.services.calibre-web = {
      enable = mkEnableOption "Calibre Web";

      booksLibraryDir = mkOption {
        description = "Local path to data directory containing book files";
        type = types.str;
        default = "/data/media/Books";
      };

      mangaLibraryDir = mkOption {
        description = "Local path to data directory containing manga files";
        type = types.str;
        default = "/data/media/Manga";
      };

      comicsLibraryDir = mkOption {
        description = "Local path to data directory containing comic files";
        type = types.str;
        default = "/data/media/Comics";
      };
    };
  };

  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers = {
      calibre-web-books = {
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
          "${cfg.booksLibraryDir}:/books:ro"
          "calibre_books_config:/config"
        ];
      };

      calibre-web-manga = {
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

        ports = [ "127.0.0.1:8086:8083" ];

        volumes = [
          "${cfg.mangaLibraryDir}:/books:ro"
          "calibre_manga_config:/config"
        ];
      };

      calibre-web-comics = {
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

        ports = [ "127.0.0.1:8087:8083" ];

        volumes = [
          "${cfg.comicsLibraryDir}:/books:ro"
          "calibre_comics_config:/config"
        ];
      };
    };

    services.caddy.virtualHosts."books.routing.rocks".extraConfig = ''
      import private

      reverse_proxy * 127.0.0.1:8083
    '';

    services.caddy.virtualHosts."manga.routing.rocks".extraConfig = ''
      import private

      reverse_proxy * 127.0.0.1:8086
    '';

    services.caddy.virtualHosts."comics.routing.rocks".extraConfig = ''
      import private

      reverse_proxy * 127.0.0.1:8087
    '';

    services.restic.backups.calibre-web = {
      initialize = true;
      paths = [
        "/var/lib/containers/storage/volumes/calibre_books_config"
        "/var/lib/containers/storage/volumes/calibre_manga_config"
      ];
      pruneOpts = [
        "--keep-daily 7"
      ];
    };
  };
}
