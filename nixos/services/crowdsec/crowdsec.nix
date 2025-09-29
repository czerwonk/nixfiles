{
  lib,
  config,
  ...
}:

with lib;

let
  cfg = config.my.services.crowdsec;

in
{
  options = {
    my.services.crowdsec = {
      enable = mkEnableOption "CrowSec Security Engine (including firewall-bouncer for nftables)";

      bouncerApiKey = mkOption {
        type = types.str;
        description = "API key to use for bouncer to communicate with the crowdsec engine";
      };

      collections = mkOption {
        type = types.listOf types.str;
        default = [ ];
        description = "Collections to install";
      };

      metricsListenAddr = mkOption {
        type = types.str;
        default = "127.0.0.1";
        description = "Address to listen for metrics calls";
      };

      autoStart = mkOption {
        type = types.bool;
        default = true;
        description = "Wether to start crowdsec on boot";
      };

      enableMitigation = mkOption {
        type = types.bool;
        default = true;
        description = "Wether to enabled crowdsec mitigation";
      };
    };
  };

  config = mkIf cfg.enable {
    services.crowdsec = {
      enable = true;
      localConfig = {
        acquisitions = [
          {
            source = "journalctl";
            journalctl_filter = [ "_SYSTEMD_UNIT=sshd.service" ];
            labels.type = "syslog";
          }
          {
            source = "journalctl";
            journalctl_filter = [ "-k" ];
            labels.type = "syslog";
          }
          {
            filenames = [ "/var/log/audit/*.log" ];
            labels.type = "auditd";
          }
        ];
      };
      settings = {
        general = {
          api.server.listen_uri = "127.0.0.1:8000";
        };
      };
    };

    systemd.services.crowdsec = {
      wantedBy = mkIf (!cfg.autoStart) (lib.mkForce [ ]);
      serviceConfig = {
        ExecStartPre = lib.mkAfter ''
          if ! cscli bouncers list | grep -q 'firewall-bouncer'; then
            cscli bouncers add "firewall-bouncer" --key "${cfg.bouncerApiKey}"
          fi
        '';
      };
    };

    users.users.crowdsec.extraGroups = [ "audit" ];
  };
}
