{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.my.services.ntfy;
  version = "v2.9.0";

in {
  options = {
    my.services.ntfy = {
      enable = mkEnableOption "ntfy";
    };
  };

  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers = {
      ntfy = {
        image = "binwiederhier/ntfy:${version}";

        autoStart = true;
        extraOptions = [
          "--runtime=${pkgs.gvisor}/bin/runsc"
        ];
        user = "1000:1000";

        environment = {
          TZ = "Europe/Berlin";
        };

        ports = [
          "127.0.0.1:8084:80"
        ];

        volumes = [
          "ntfy-config:/etc/ntfy"
        ];
      };
    };

    services.caddy.virtualHosts."ntfy.routing.rocks".extraConfig = ''
      @blocked not remote_ip 2001:678:1e0::/48
      abort @blocked

      reverse_proxy * 127.0.0.1:8084
    '';
  };
}
