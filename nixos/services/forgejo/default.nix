{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.my.services.forgejo;
  version = "1.21.5-0-rootless";

in {
  options = {
    my.services.forgejo = {
      enable = mkEnableOption "forgejo";
    };
  };

  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers = {
      forgejo = {
        image = "codeberg.org/forgejo/forgejo:${version}";

        autoStart = true;
        extraOptions = [
          "--runtime=${pkgs.gvisor}/bin/runsc"
        ];
        user = "1000:1000";

        environment = {
          TZ = "Europe/Berlin";
        };

        ports = [
          "127.0.0.1:3003:3000"
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
