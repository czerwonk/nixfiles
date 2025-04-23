{ lib, config, ... }:

with lib;

let
  cfg = config.my.services.crowdsec;

in
{
  config = mkIf (cfg.enable && config.services.caddy.enable) {
    my.services.crowdsec.collections = [ "crowdsecurity/caddy" ];

    services.crowdsec = {
      acquisitions = [
        {
          source = "journalctl";
          journalctl_filter = [ "_SYSTEMD_UNIT=caddy.service" ];
          labels.type = "syslog";
        }
      ];
    };
  };
}
