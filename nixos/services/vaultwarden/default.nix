{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.my.services.vaultwarden;
  version = "1.30.5";

in {
  options = {
    my.services.vaultwarden.enable = mkEnableOption "Vaultwarden";
  };

  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers = {
      vaultwarden = {
        image = "vaultwarden/server:${version}-alpine";

        autoStart = true;
        extraOptions = [
          "--runtime=${pkgs.gvisor}/bin/runsc"
        ];

        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "Europe/Berlin";
          ROCKET_PORT = "8085";
          DOMAIN = "https://vaultwarden.routing.rocks";
          WEBSOCKET_ENABLED = "true";
        };

        ports = [
          "127.0.0.1:3012:3012"
          "127.0.0.1:8085:8085"
        ];

        volumes = [
          "vaultwarden-data:/data"
        ];
      };
    };

    services.caddy.virtualHosts."vaultwarden.routing.rocks".extraConfig = ''
      @blocked not remote_ip 2001:678:1e0::/48
      abort @blocked

      reverse_proxy /notifications/hub 127.0.0.1:3012
      reverse_proxy * 127.0.0.1:8085
    '';

    services.restic.backups.vaultwarden = {
      initialize = true;
      paths = [
        "/var/lib/containers/storage/volumes/vaultwarden-data"
      ];
      pruneOpts = [
        "--keep-daily 7"
      ];
    };
  };
}
