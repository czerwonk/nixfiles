{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

let
  cfg = config.my.services.crowdsec;
  registerBouncer = pkgs.writeShellScript "crowdsec-register-bouncer" ''
    if ! cscli bouncers list | grep -q 'firewall-bouncer'; then
      cscli bouncers add "firewall-bouncer" --key "${cfg.bouncerApiKey}"
    fi
  '';

in
{
  options = {
    my.services.crowdsec = {
      enable = mkEnableOption "CrowSec Security Engine (including firewall-bouncer for nftables)";

      bouncerApiKey = mkOption {
        type = types.str;
        description = "API key to use for bouncer to communicate with the crowdsec engine";
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
        lapi = {
          credentialsFile = "/var/lib/crowdsec/local_api_credentials.yaml";
        };
        general = {
          api = {
            server = {
              enable = true;
              listen_uri = "127.0.0.1:8000";
            };
          };
        };
      };
    };

    systemd.services.crowdsec = {
      wantedBy = mkIf (!cfg.autoStart) (lib.mkForce [ ]);
      serviceConfig = {
        ExecStartPre = lib.mkIf (cfg.enableMitigation) [ registerBouncer ];
      };
    };

    users.users.crowdsec.extraGroups = [ "audit" ];
  };
}
