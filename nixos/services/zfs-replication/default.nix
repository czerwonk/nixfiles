{ pkgs, lib, ... }:

with lib;

let
  zfs-replication = pkgs.writeShellScriptBin "zfs-sync" ''
    # Script to replicate datasets to this server
    # Required permissions: send,snapshot,hold,mount,destroy

    set -e

    sync() {
      syncoid --no-privilege-elevation --delete-target-snapshots --sendoptions="w" --sshport=2222 $1 $2
    }

    sync backup@bb1.dus.routing.rocks:zroot/persist zroot/replication/bb1-dus/persist
    sync backup@bb2.dus.routing.rocks:zroot/persist zroot/replication/bb2-dus/persist
    sync backup@homey.ess.routing.rocks:zroot/replication/steffi zroot/replication/steffi
    sync backup@homey.ess.routing.rocks:zroot/replication/fmeo. zroot/replication/fmeo
    ${lib.flip lib.concatMapStrings config.my.zfs-replication.targets (target: ''
      sync ${target}
    '')}
  '';

in {
  options = {
    my.zfs-replication.enable = mkEnableOption "ZFS-Replication";

    my.zfs-replication.targets = mkOption {
      description = mdDoc "Targets to replicate to the local machine";
      example = [ "user@server:zroot/my-dataset zpool/my-dataset" ];
      type = types.listOf types.str;
      default = [];
    };
  };

  config = {
    systemd.timers.zfs-replication = {
      timerConfig = {
        Unit = "zfs-replication.service";
        OnCalendar = "*-*-* *:00:00";
      };
      wantedBy = [ "timers.target" ];
      partOf = [ "zfs-replication.service" ];
    };

    systemd.services.zfs-replication = {
      description = "ZFS replication";
      path = with pkgs; [
        lzop
        mbuffer
        openssh
        sanoid
        zsh
      ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${zfs-replication}/bin/zfs-sync";

        ProtectSystem = "strict";
        PrivateTmp = true;
        ProtectHostname = true;
        ProtectClock = true;
        ProtectControlGroups = true;
        ProtectKernelTunables = true;
        ProtectKernelModules = true;

        ReadWritePaths = [
          "/tmp"
        ];

        ExecPaths = ["/nix/store"];
        NoExecPaths = ["/"];
      };
    };
  };
}
