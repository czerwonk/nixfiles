{ lib, config, ... }:

with lib;

let
  cfg = config.services.custom.calibre-web;

in {
  options = {
    services.custom.calibre-web = {
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
        image = "lscr.io/linuxserver/calibre-web";
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "Europe/Berlin";
        };
        autoStart = true;
        ports = [ "127.0.0.1:8083:8083" ];
        volumes = [
          "${cfg.libraryDir}:/books:ro"
          "calibre_config:/config"
        ];
      };
    };

    services.caddy.virtualHosts."books.routing.rocks".extraConfig = ''
      @blocked not remote_ip 2001:678:1e0::/48
      abort @blocked

      reverse_proxy * 127.0.0.1:8083
    '';
  };
}