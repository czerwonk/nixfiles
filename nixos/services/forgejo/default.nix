{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.my.services.forgejo;
  version = "1.21.6-0-rootless";

in {
  options = {
    my.services.forgejo = {
      enable = mkEnableOption "forgejo";
    };
  };

  config = mkIf cfg.enable {
    systemd.services.podman-create-forgejo-net = {
      serviceConfig.Type = "oneshot";
      wantedBy = [ "podman-forgejo.service" ];
      path = [ pkgs.podman ];
      script = ''
        podman network exists forgejo || podman network create forgejo --ipv6
      '';
    };

    virtualisation.oci-containers.containers = {
      forgejo = {
        image = "codeberg.org/forgejo/forgejo:${version}";

        autoStart = true;
        extraOptions = [
          "--runtime=${pkgs.gvisor}/bin/runsc"
          "--network=forgejo"
        ];
        user = "1000:1000";

        environment = {
          TZ = "Europe/Berlin";
        };

        ports = [
          "3003:3000"
          "22:2222"
        ];

        volumes = [
          "forgejo-data:/var/lib/gitea"
          "forgejo-config:/etc/gitea"
        ];
      };
    };

    services.caddy.virtualHosts."code.routing.rocks".extraConfig = ''
      @blocked not remote_ip 2001:678:1e0::/48
      abort @blocked

      reverse_proxy * 127.0.0.1:3003
    '';

    services.restic.backups.forgejo = {
      initialize = true;
      paths = [
        "/var/lib/containers/storage/volumes/forgejo-data/_data/"
        "/var/lib/containers/storage/volumes/forgejo-config/_data/"
      ];
      pruneOpts = [
        "--keep-daily 7"
      ];
    };
  };
}
