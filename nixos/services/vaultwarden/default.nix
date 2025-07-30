{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

let
  cfg = config.my.services.vaultwarden;
  version = "1.34.3";

in
{
  options = {
    my.services.vaultwarden = {
      enable = mkEnableOption "Vaultwarden";

      yubico_client_id = mkOption {
        type = types.str;
        description = "Client ID to use with Yubico API";
      };

      yubico_api_key = mkOption {
        type = types.str;
        description = "Secret API Key to use with Yubico API";
      };

      admin_token = mkOption {
        type = types.str;
        description = "Admin Token to access the admin interface";
      };
    };
  };

  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers = {
      vaultwarden = {
        image = "vaultwarden/server:${version}-alpine";

        autoStart = true;
        extraOptions = [
          "--runtime=${pkgs.gvisor}/bin/runsc"
        ];
        user = "1000:1000";

        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "Europe/Berlin";
          ROCKET_PORT = "8085";
          DOMAIN = "https://vaultwarden.routing.rocks";
          YUBICO_CLIENT_ID = cfg.yubico_client_id;
          YUBICO_SECRET_KEY = cfg.yubico_api_key;
          ADMIN_TOKEN = cfg.admin_token;
          SIGNUPS_ALLOWED = "false";
          INVITATIONS_ALLOWED = "false";
          EMAIL_CHANGE_ALLOWED = "false";
        };

        ports = [
          "127.0.0.1:8085:8085"
        ];

        volumes = [
          "vaultwarden-data:/data"
        ];
      };
    };

    services.caddy.virtualHosts."vaultwarden.routing.rocks".extraConfig = ''
      import private

      encode gzip

      reverse_proxy * 127.0.0.1:8085
    '';

    services.restic.backups.vaultwarden = {
      initialize = true;
      paths = [
        "/var/lib/containers/storage/volumes/vaultwarden-data"
      ];
      pruneOpts = [
        "--keep-daily 90"
      ];
    };
  };
}
