{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.services.custom.ripe-atlas;
  regservers = pkgs.writeScriptBin "reg_servers.sh" ''
    REG_1_HOST=2001:67c:2e8:11::c100:13f6
    REG_2_HOST=2001:67c:2e8:11::c100:13f7
  '';

in {
  options = {
    services.custom.ripe-atlas = {
      enable = mkEnableOption "RIPE Atlas Probe";
    };
  };

  config = mkIf cfg.enable {
    systemd.services.podman-create-ripe-atlas-net = {
      serviceConfig.Type = "oneshot";
      wantedBy = [ "podman-ripe-atlas.service" ];
      path = [ pkgs.podman ];
      script = ''
        podman network exists ripe-atlas || podman network create ripe-atlas --ipv6 --subnet=2001:678:1e0:f200::/64 --gateway=2001:678:1e0:f200::1
      '';
    };

    virtualisation.oci-containers.containers = {
      ripe-atlas = {
        autoStart = true;
        extraOptions = [
          "--network=ripe-atlas"
          "--cap-drop=all"
          "--cap-add=CHOWN,SETUID,SETGID,DAC_OVERRIDE,NET_RAW"
        ];

        image = "jamesits/ripe-atlas";

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

    networking.firewall.extraCommands = lib.mkAfter ''
      ip6tables -t nat -I POSTROUTING -s 2001:678:1e0:f200::/64 -j RETURN
    '';
  };
}
