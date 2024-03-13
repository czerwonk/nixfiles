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

    services.crowdsec = {
      enable = true;
      package = pkgs.crowdsec;
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
    };

    systemd.services.crowdsec.serviceConfig = {
      ProcSubset = "all";
      ExecStartPre = let
        script = pkgs.writeScriptBin "pre-start" ''
          #!${pkgs.runtimeShell}
          set -eu
          set -o pipefail

          ${lib.concatLines (map (collection: ''
            if ! cscli collections list | grep -q '${collection}'; then
              cscli collections install ${collection}
            fi
          '') cfg.collections)}

          if ! cscli bouncers list | grep -q 'firewall-bouncer'; then
            cscli bouncers add "firewall-bouncer" --key "${cfg.bouncerApiKey}"
          fi
        '';
        in ["${script}/bin/pre-start"];
    };

    services.crowdsec-firewall-bouncer = {
      enable = true;
      settings = {
        api_key = cfg.bouncerApiKey;
        api_url = "http://127.0.0.1:8000";
        mode = "nftables";
        blacklists_ipv4 = "blocklist-crowdsec-v4";
        blacklists_ipv6 = "blocklist-crowdsec-v6";
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

    users.users.crowdsec.extraGroups = [ "systemd-journal" ];

    networking.nftables.tables."nixos-fw".content = lib.mkBefore ''
      set blocklist-crowdsec-v4 {
        type ipv4_addr
        flags timeout
      }

      set blocklist-crowdsec-v6 {
        type ipv6_addr
        flags timeout
      }

      chain crowdsec {
        type filter hook input priority filter - 1; policy accept;
        ip6 saddr 2001:678:1e0::/48 accept
        ip saddr @blocklist-crowdsec-v4 counter drop
        ip6 saddr @blocklist-crowdsec-v6 counter drop
      }
    '';
  };
}
