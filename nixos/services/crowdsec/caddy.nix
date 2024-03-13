{ lib, config, ... }:

with lib;

let
  cfg = config.my.services.crowdsec;

in {
  config = mkIf (cfg.enable && config.services.caddy.enable) {
    my.services.crowdsec.collections = cfg.collections ++ [ "crowdsecurity/caddy" ];

    environment.etc."crowdsec/acquis/caddy.yaml".text = ''
      source: journalctl
      journalctl_filter:
       - "_SYSTEMD_UNIT=caddy.service"
      labels:
        type: syslog
    '';
  };
}
