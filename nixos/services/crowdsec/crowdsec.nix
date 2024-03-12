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
    };
  };

  config = mkIf cfg.enable {
    environment.etc."crowdsec/acquis.yaml".text = ''
      ---
      source: journalctl
      journalctl_filter:
       - "_SYSTEMD_UNIT=sshd.service"
      labels:
        type: syslog
      ---
    '';

    services.crowdsec = {
      enable = true;
      package = pkgs.crowdsec;
      settings = {
        api.server = {
          enable = true;
          listen_uri = "127.0.0.1:8000";
          trusted_ips = [ "127.0.0.1" "::1" ];
        };
        crowdsec_service = {
          acquisition_path = "/etc/crowdsec/acquis.yaml";
        };
        cscli = {
          output = "human";
          color = "auto";
        };
        prometheus = {
          enabled = true;
          level = "full";
          listen_addr = "127.0.0.1";
          listen_port = 6060;
        };
      };
    };

    systemd.services.crowdsec.serviceConfig.ExecStartPre = let
      script = pkgs.writeScriptBin "pre-start" ''
        #!${pkgs.runtimeShell}
        set -eu
        set -o pipefail

        cscli collections install crowdsecurity/sshd

        if ! cscli bouncers list | grep -q "firewall-bouncer"; then
          cscli bouncers add "firewall-bouncer" --key "${cfg.bouncerApiKey}"
        fi
      '';
      in ["${script}/bin/pre-start"];

    services.crowdsec-firewall-bouncer = {
      enable = true;
      settings = {
        api_key = cfg.bouncerApiKey;
        api_url = "http://127.0.0.1:8000";
        mode = "nftables";
        blacklists_ipv4 = "crowdsec-blacklists";
        blacklists_ipv6 = "crowdsec6-blacklists";
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

    networking.nftables.tables."nixos-fw".content = lib.mkBefore ''
      set crowdsec-blacklists {
        type ipv4_addr
        flags timeout
      }

      set crowdsec6-blacklists {
        type ipv6_addr
        flags timeout
      }
    '';

    networking.firewall.extraInputRules = lib.mkBefore ''
      ip saddr @crowdsec-blacklists drop
      ip6 saddr @crowdsec6-blacklists drop
    '';
  };
}
