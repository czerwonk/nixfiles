{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

let
  cfg = config.my.services.hakanai;
  version = "v1.4.0";

in
{
  options = {
    my.services.hakanai = {
      enable = mkEnableOption "hakanai - A minimalist one-time secret sharing service. Share sensitive data through ephemeral links that self-destruct after a single view.";
    };

    my.services.hakanai.tokens_env = mkOption {
      type = types.str;
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
          HAKANAI_TOKENS = cfg.tokens_env;
        };

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

    services.caddy.virtualHosts."hakanai.routing.rocks".extraConfig = ''
      import common

      reverse_proxy * 127.0.0.1:2284
    '';
  };
}
