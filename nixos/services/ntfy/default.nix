{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.my.services.ntfy;
  version = "v2.11.0";

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
        cmd = [ "serve" ];

        autoStart = true;
        extraOptions = [
          #"--runtime=${pkgs.gvisor}/bin/runsc"
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
      import private

      reverse_proxy * 127.0.0.1:8084
    '';
  };
}
