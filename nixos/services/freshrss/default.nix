{ lib, config, ... }:

with lib;

let
  cfg = config.my.services.freshrss;

in {
  options = {
    my.services.freshrss = {
      enable = mkEnableOption "FreshRSS";
    };
  };

  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers = {
      freshrss = {
        image = "lscr.io/linuxserver/freshrss";
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "Europe/Berlin";
        };
        autoStart = true;
        ports = [ "127.0.0.1:1080:80" ];
        volumes = [
          "freshrss_data:/config"
        ];
      };
    };

    services.caddy.virtualHosts."rss.routing.rocks".extraConfig = ''
      @blocked not remote_ip 2001:678:1e0::/48
      abort @blocked

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
