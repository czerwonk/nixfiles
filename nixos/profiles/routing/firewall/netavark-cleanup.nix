{ pkgs, lib, config, ... }:

let
  netavark-cleanup = pkgs.writeShellScriptBin "netavark-cleanup" ''
    set -euo pipefail

    if ! ${pkgs.nftables}/bin/nft -a list chain inet netavark FORWARD >/tmp/netavark-forward.rules 2>/dev/null; then
      exit 0
    fi

    ${pkgs.gawk}/bin/awk '/ct state invalid drop/ { for (i = 1; i <= NF; i++) if ($i == "handle") print $(i + 1) }' \
      /tmp/netavark-forward.rules \
      | while read -r handle; do
          ${pkgs.nftables}/bin/nft delete rule inet netavark FORWARD handle "$handle"
        done
  '';

in
{
  config = lib.mkIf config.virtualisation.podman.enable {
    systemd.timers.netavark-cleanup = {
      wantedBy = [ "timers.target" ];
      partOf = [ "netavark-cleanup.service" ];
      timerConfig = {
        Unit = "netavark-cleanup.service";
        OnBootSec = "1m";
        OnUnitActiveSec = "1m";
      };
    };

    systemd.services.netavark-cleanup = {
      description = "Remove netavark nftables rules that break routing (ct state invalid drop)";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${netavark-cleanup}/bin/netavark-cleanup";

        ProtectSystem = "strict";
        ProtectHome = true;
        PrivateTmp = true;
        ProtectHostname = true;
        ProtectClock = true;
        ProtectControlGroups = true;
        ProtectKernelTunables = true;
        ProtectKernelModules = true;
        NoNewPrivileges = true;
        RestrictAddressFamilies = [ "AF_NETLINK" ];

        ExecPaths = [ "/nix/store" ];
        NoExecPaths = [ "/" ];
      };
    };
  };
}
