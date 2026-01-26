{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

let
  cfg = config.my.services.bentopdf;
  version = "v1.16.1";

in
{
  options = {
    my.services.bentopdf = {
      enable = mkEnableOption "bentopdf";

      domain = mkOption {
        type = types.str;
        default = "pdf.routing.rocks";
        description = "The domain to use for bentopdf.";
      };
    };
  };

  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers = {
      bentopdf = {
        image = "bentopdf/bentopdf-simple:${version}";

        autoStart = true;
        extraOptions = [
          "--runtime=${pkgs.gvisor}/bin/runsc"
        ];
        user = "101:101";

        environment = {
          TZ = "Europe/Berlin";
        };

        ports = [
          "127.0.0.1:8088:8080"
        ];
      };
    };

    services.caddy.virtualHosts.${cfg.domain}.extraConfig = ''
      import private

      reverse_proxy * 127.0.0.1:8088
    '';
  };
}
