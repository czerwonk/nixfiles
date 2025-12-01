{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

let
  cfg = config.my.services.hakanai;
  version = "v2.20.1";

in
{
  options = {
    my.services.hakanai = {
      enable = mkEnableOption "hakanai - A minimalist one-time secret sharing service. Share sensitive data through ephemeral links that self-destruct after a single view.";
    };
  };

  config = mkIf cfg.enable {
    systemd.services.podman-create-hakanai-net = {
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

        ExecPaths = [ "/nix/store" ];
        NoExecPaths = [ "/" ];
      };
      wantedBy = [ "podman-hakanai-server.service" ];
      path = [ pkgs.podman ];
      script = ''
        podman network exists hakanai || podman network create hakanai
      '';
    };

    virtualisation.oci-containers.containers = {
      hakanai-server = {
        image = "ghcr.io/czerwonk/hakanai:${version}";

        autoStart = true;
        extraOptions = [
          "--runtime=${pkgs.gvisor}/bin/runsc"
          "--network=hakanai"
        ];
        user = "65532";

        environment = {
          HAKANAI_REDIS_DSN = "redis://hakanai-redis:6379";
          HAKANAI_PORT = "8080";
          HAKANAI_LISTEN_ADDRESS = "0.0.0.0";
          HAKANAI_UPLOAD_SIZE_LIMIT = "100m";
          HAKANAI_ALLOW_ANONYMOUS = "true";
          HAKANAI_ANONYMOUS_UPLOAD_SIZE_LIMIT = "32k";
          HAKANAI_IMPRESSUM_FILE = "/static/impressum.html";
          HAKANAI_PRIVACY_FILE = "/static/privacy.html";
          HAKANAI_TRUSTED_IP_RANGES = "2001:678:1e0::/48";
          HAKANAI_TRUSTED_IP_HEADER = "cf-connecting-ip";
          HAKANAI_COUNTRY_HEADER = "cf-ipcountry";
          HAKANAI_ASN_HEADER = "x-client-asn";
          OTEL_EXPORTER_OTLP_ENDPOINT = "http://host.containers.internal:4317";
        };

        volumes = [
          "hakanai-static-data:/static"
        ];

        ports = [ "127.0.0.1:2284:8080" ];

        dependsOn = [
          "hakanai-redis"
        ];
      };

      hakanai-redis = {
        image = "valkey/valkey:alpine";

        autoStart = true;
        extraOptions = [
          "--network=hakanai"
        ];

        environment = {
          TZ = "Europe/Berlin";
        };

        volumes = [
          "hakanai-redis-data:/data"
        ];
      };
    };

    services.caddy.virtualHosts."hakanai.link".extraConfig = ''
      import common
      import cloudflare_only

      reverse_proxy 127.0.0.1:2284 {
        import cloudflare_headers
      }
    '';
  };
}
