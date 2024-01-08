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
    systemd.services.nextcloud = {
      description = "Nextcloud";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      path = [ pkgs.podman ];
      serviceConfig = {
        WorkingDirectory = "/opt/nextcloud-aio";
        Type = "simple";
        ExecStart = "${pkgs.podman-compose}/bin/podman-compose up -d";
        ExecStop = "${pkgs.podman-compose}/bin/podman-compose down";
        RemainAfterExit = true;
        Restart = "always";
        RestartSec = 60;
      };
    };

    services.caddy.virtualHosts."nextcloud.routing.rocks".extraConfig = ''
      @blocked not remote_ip 2001:678:1e0::/48
      abort @blocked

      reverse_proxy * 127.0.0.1:11000

      encode gzip
    '';
  };
}
