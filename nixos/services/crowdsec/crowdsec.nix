{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.my.services.crowdsec;

in {
  options = {
    my.services.crowdsec = {
      enable = mkEnableOption "CrowSec Security Engine (including firewall-bouncer for nftables)";

      bouncerApiKey = mkOption {
        type = types.str;
        description = "API key to use for bouncer to communicate with the crowdsec engine";
      };

      collections = mkOption {
        type = types.listOf types.str;
        default = [];
        description = "Collections to install";
      };

      metricsListenAddr = mkOption {
        type = types.str;
        default = "127.0.0.1";
        description = "Address to listen for metrics calls";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.etc."crowdsec/acquis/sshd.yaml".text = ''
      source: journalctl
      journalctl_filter:
       - "_SYSTEMD_UNIT=sshd.service"
      labels:
        type: syslog
    '';
    environment.etc."crowdsec/acquis/kernel.yaml".text = ''
      source: journalctl
      journalctl_filter:
       - "-k"
      labels:
        type: syslog
    '';

    services.crowdsec = {
      enable = true;
      package = pkgs.crowdsec;
      allowLocalJournalAccess = true;
      settings = {
        api.server = {
          enable = true;
          listen_uri = "127.0.0.1:8000";
        };
        crowdsec_service = {
          acquisition_dir = "/etc/crowdsec/acquis";
        };
        cscli = {
          output = "human";
          color = "auto";
        };
        prometheus = {
          enabled = true;
          level = "full";
          listen_addr = cfg.metricsListenAddr;
          listen_port = 6060;
        };
      };
      extraExecStartPre = ''
        ${lib.concatLines (map (collection: ''
          if ! cscli collections list | grep -q '${collection}'; then
            cscli collections install ${collection}
          fi
        '') cfg.collections)}

        if ! cscli bouncers list | grep -q 'firewall-bouncer'; then
          cscli bouncers add "firewall-bouncer" --key "${cfg.bouncerApiKey}"
        fi
      '';
    };

    services.crowdsec-firewall-bouncer = {
      enable = true;
      settings = {
        api_key = cfg.bouncerApiKey;
        api_url = "http://127.0.0.1:8000";
        mode = "nftables";
        blacklists_ipv4 = "blocklist-v4";
        blacklists_ipv6 = "blocklist-v6";
        nftables = {
          ipv4 = {
            table = "nixos-fw";
            enabled = true;
            set-only = true;
          };
          ipv6 = {
            table = "nixos-fw";
            enabled = true;
            set-only = true;
          };
        };
      };
    };
  };
}
