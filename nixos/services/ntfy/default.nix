{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

let
  cfg = config.my.services.ntfy;
  version = "v2.16.0";

in
{
  options = {
    my.services.ntfy = {
      enable = mkEnableOption "ntfy";

      domain = mkOption {
        type = types.str;
        default = "ntfy.routing.rocks";
        description = "The domain to use for ntfy.";
      };

      network = mkOption {
        type = types.str;
        default = "podman";
        description = "The network to use for ntfy.";
      };
    };
  };

  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers = {
      ntfy = {
        image = "binwiederhier/ntfy:${version}";
        cmd = [ "serve" ];

        autoStart = true;
        extraOptions = [
          "--runtime=${pkgs.gvisor}/bin/runsc"
          "--network=${cfg.network}"
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

    services.caddy.virtualHosts.${cfg.domain}.extraConfig = ''
      import private

      reverse_proxy * 127.0.0.1:8084
    '';
  };
}
