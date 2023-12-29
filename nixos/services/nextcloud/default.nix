{ lib, config, ... }:

with lib;

let
  cfg = config.services.custom.nextcloud;

in {
  options = {
    services.custom.nextcloud = {
      enable = mkEnableOption "Nextcloud (All In One)";
    };
  };

  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers = {
      nextcloud-aio-mastercontainer = {
        image = "nextcloud/all-in-one";
        autoStart = true;
        ports = [ "127.0.0.1:11000:11000" ];
        volumes = [
          "nextcloud_config:/mnt/docker-aio-config"
          "nextcloud_data:/mnt/ncdata"
        ];
        environment = {
          APACHE_PORT = 11000;
          APACHE_IP_BINDING = "0.0.0.0";
        };
      };
    };
  };
}
