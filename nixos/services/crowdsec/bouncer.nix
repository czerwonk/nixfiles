{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.my.services.crowdsec;
  configFile = pkgs.writeText "crowdsec-firewall-bouncer.yaml" ''
    api_key: ${cfg.bouncerApiKey}
    api_url: http://127.0.0.1:8000
    blacklists_ipv4: blocklist-v4
    blacklists_ipv6: blocklist-v6
    deny_action: DROP
    log_mode: stdout
    mode: nftables
    nftables:
      ipv4:
        enabled: true
        set-only: true
        table: nixos-fw
      ipv6:
        enabled: true
        set-only: true
        table: nixos-fw
    update_frequency: 10s
  '';

in
{
  config = lib.mkIf (cfg.enable && cfg.enableMitigation) {
    systemd.services = {
      crowdsec-firewall-bouncer = {
        description = "Crowdsec Firewall Bouncer";

        path = [
          pkgs.nftables
        ];

        wantedBy = [ "multi-user.target" ];

        serviceConfig = with lib; {
          Type = "notify";
          Restart = "on-failure";
          RestartSec = 10;

          LimitNOFILE = mkDefault 65536;

          MemoryDenyWriteExecute = mkDefault true;

          CapabilityBoundingSet = mkDefault [
            "CAP_NET_ADMIN"
            "CAP_NET_RAW"
          ];

          NoNewPrivileges = mkDefault true;
          LockPersonality = mkDefault true;
          RemoveIPC = mkDefault true;

          ProtectSystem = mkDefault "strict";
          ProtectHome = mkDefault true;

          PrivateTmp = mkDefault true;
          PrivateDevices = mkDefault true;
          ProtectHostname = mkDefault true;
          ProtectKernelTunables = mkDefault true;
          ProtectKernelModules = mkDefault true;
          ProtectControlGroups = mkDefault true;

          ProtectProc = mkDefault "invisible";
          ProcSubset = mkDefault "pid";

          RestrictNamespaces = mkDefault true;
          RestrictRealtime = mkDefault true;
          RestrictSUIDSGID = mkDefault true;

          SystemCallFilter = mkDefault [
            "@system-service"
            "@network-io"
          ];
          SystemCallArchitectures = [ "native" ];
          SystemCallErrorNumber = mkDefault "EPERM";

          ExecPaths = [ "/nix/store" ];
          NoExecPaths = [ "/" ];

          ExecStartPost = "${pkgs.coreutils}/bin/sleep 0.2";

          ExecStart = "${pkgs.crowdsec-firewall-bouncer}/bin/cs-firewall-bouncer -c ${configFile}";
          ExecStartPre = [ "${pkgs.crowdsec-firewall-bouncer}/bin/cs-firewall-bouncer -t -c ${configFile}" ];
        };
      };
    };
  };
}
