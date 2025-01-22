{ pkgs, lib, config, ... }:

with lib;

let
  zfs-replication = pkgs.writeShellScriptBin "zfs-sync" ''
    # Script to replicate datasets to this server
    # Required permissions: send,snapshot,hold,mount,destroy
    has_error=0

    sync() {
      syncoid --no-privilege-elevation --no-sync-snap --delete-target-snapshots --sendoptions="w" --sshport=2222 $1 $2
    }

    ${lib.flip lib.concatMapStrings config.my.zfs-replication.targets (target: ''
      sync ${target} || has_error=1
    '')}

    if [ $has_error -gt 0 ]; then
      exit 1
    fi
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

  config = mkIf config.my.zfs-replication.enable {
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
        flock
        lzop
        mbuffer
        openssh
        sanoid
        zsh
      ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${lib.getExe pkgs.flock} -n /tmp/zfs-replication.lock ${zfs-replication}/bin/zfs-sync";

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
