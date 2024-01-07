{ lib, config, ... }:

with lib;

let
  cfg = config.services.custom.ripe-atlas;

in {
  options = {
    services.custom.ripe-atlas = {
      enable = mkEnableOption "RIPE Atlas Probe";
    };
  };

  config = mkIf cfg.enable {
    systemd.services.ripe-atlas-probe = {
      description = "Atlas Software Probe";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      path = [ pkgs.podman ];
      serviceConfig = {
        WorkingDirectory = "/opt/docker-ripe-atlas";
        Type = "simple";
        ExecStart = "${pkgs.podman-compose}/bin/podman-compose up -d";
        ExecStop = "${pkgs.podman-compose}/bin/podman-compose down";
        RemainAfterExit = true;
        Restart = "always";
        RestartSec = 60;
      };
    };
  };
}
