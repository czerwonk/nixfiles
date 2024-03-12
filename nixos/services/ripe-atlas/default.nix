{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.my.services.ripe-atlas;
  regservers = pkgs.writeScriptBin "reg_servers.sh" ''
    REG_1_HOST=2001:67c:2e8:11::c100:13f6
    REG_2_HOST=2001:67c:2e8:11::c100:13f7
  '';

in {
  options = {
    my.services.ripe-atlas = {
      enable = mkEnableOption "RIPE Atlas Probe";
    };
  };

  config = mkIf cfg.enable {
    systemd.services.podman-create-ripe-atlas-net = {
      serviceConfig = {
        Type = "oneshot";

        ProtectSystem = "strict";
        ProtectHostname = true;
        ProtectClock = true;
        ProtectKernelTunables = true;
        ProtectKernelModules = true;

        ReadWritePaths = [
          "/etc/containers"
          "/var/lib/containers"
        ];

        ExecPaths = ["/nix/store"];
        NoExecPaths = ["/"];
      };
      wantedBy = [ "podman-ripe-atlas.service" ];
      path = [ pkgs.podman ];
      script = ''
        podman network exists ripe-atlas || podman network create ripe-atlas --ipv6 --subnet=2001:678:1e0:f200::/64 --gateway=2001:678:1e0:f200::1
      '';
    };

    virtualisation.oci-containers.containers = {
      ripe-atlas = {
        image = "jamesits/ripe-atlas";

        autoStart = true;
        extraOptions = [
          "--runtime=${pkgs.gvisor}/bin/runsc"
          "--network=ripe-atlas"
          "--cap-drop=all"
          "--cap-add=CHOWN,SETUID,SETGID,DAC_OVERRIDE,NET_RAW"
        ];

        environment = {
          RXTXRPT = "yes";
        };

        volumes = [
          "docker-ripe-atlas_etc:/var/atlas-probe/etc"
          "docker-ripe-atlas_status:/var/atlas-probe/status"
          "${regservers}/bin/reg_servers.sh:/var/atlas-probe/bin/reg_servers.sh"
        ];
      };
    };
  };
}
