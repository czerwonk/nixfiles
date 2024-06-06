{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.my.services.freshrss;
  version = "1.24.1";

in {
  options = {
    my.services.freshrss = {
      enable = mkEnableOption "FreshRSS";
    };
  };

  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers = {
      freshrss = {
        image = "lscr.io/linuxserver/freshrss:${version}";

        autoStart = true;
        extraOptions = [
          "--runtime=${pkgs.gvisor}/bin/runsc"
        ];

        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "Europe/Berlin";
        };

        ports = [ "127.0.0.1:1080:80" ];

        volumes = [
          "freshrss_data:/config"
        ];
      };
    };

    services.caddy.virtualHosts."rss.routing.rocks".extraConfig = ''
      import private

      reverse_proxy * 127.0.0.1:1080
    '';

    services.restic.backups.freshrss = {
      initialize = true;
      paths = [
        "/var/lib/containers/storage/volumes/freshrss_data/_data/"
      ];
      pruneOpts = [
        "--keep-daily 7"
      ];
    };
  };
}
