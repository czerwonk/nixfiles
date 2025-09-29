{ lib, config, ... }:

with lib;

let
  cfg = config.my.services.crowdsec;

in
{
  config = mkIf (cfg.enable && config.services.caddy.enable) {
    services.crowdsec.hub.collections = [ "crowdsecurity/caddy" ];

    services.crowdsec.localConfig.acquisitions = [
      {
        journalctl_filter = [
          "_SYSTEMD_UNIT=caddy.service"
        ];
        labels = {
          type = "syslog";
        };
        source = "journalctl";
      }
    ];
  };
}
