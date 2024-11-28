{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.my.services.nordvpn;

in {
  options = {
    my.services.nordvpn = {
      enable = mkEnableOption "NordVPN traffic routing";

      token = mkOption {
        type = types.str;
        description = "Token to start VPN connection";
      };

      country = mkOption {
        type = types.str;
        description = "Country to use for the VPN connection";
      };

      interface = mkOption {
        type = types.str;
        description = "Name of the bridge";
      };

      ip = mkOption {
        type = types.str;
        description = "IP address of the nordvpn container";
      };

      gateway = mkOption {
        type = types.str;
        description = "IP address of the gateway";
      };

      subnet = mkOption {
        type = types.str;
        description = "Local subnet";
      };
    };
  };

  config = mkIf cfg.enable {

    boot.kernelModules = [
      "iptables"
    ];

    systemd.services.podman-create-nordvpn-net = {
      serviceConfig = {
        Type = "oneshot";

        ProtectSystem = "strict";
        ProtectHostname = true;
        ProtectClock = true;
        ProtectControlGroups = true;
        ProtectKernelTunables = true;
        ProtectKernelModules = true;

        ReadWritePaths = [
          "/etc/containers"
          "/var/lib/containers"
        ];

        ExecPaths = ["/nix/store"];
        NoExecPaths = ["/"];
      };
      wantedBy = [ "podman-nordvpn.service" ];
      path = [ pkgs.podman ];
      script = ''
        podman network exists nordvpn || podman network create nordvpn --interface-name=${cfg.interface} --gateway=${cfg.gateway} --subnet=${cfg.subnet}
      '';
    };

    virtualisation.oci-containers.containers = {
      nordvpn = {
        image = "ghcr.io/bubuntux/nordvpn";

        autoStart = true;
        extraOptions = [
          "--network=nordvpn"
          "--cap-add=NET_ADMIN,NET_RAW"
          "--ip=${cfg.ip}"
        ];

        environment = {
          CONNECT = "${cfg.country}";
          TECHNOLOGY = "NordLynx";
          TOKEN = "${cfg.token}";
          NET_LOCAL = "${cfg.subnet}";
        };
      };
    };
  };
}
