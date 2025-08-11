{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

let
  cfg = config.my.services.hakanai;
  version = "v2.8.2";

in
{
  options = {
    my.services.hakanai = {
      enable = mkEnableOption "hakanai - A minimalist one-time secret sharing service. Share sensitive data through ephemeral links that self-destruct after a single view.";

      impressumFile = mkOption {
        type = types.str;
      };

      privacyFile = mkOption {
        type = types.str;
      };
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
          HAKANAI_ENABLE_ADMIN_TOKEN = "true";
          HAKANAI_IMPRESSUM_FILE = "/app/impressum.html";
          HAKANAI_PRIVACY_FILE = "/app/privacy.html";
          HAKANAI_WEBHOOK_URL = "https://ntfy.hakanai.link/webhook";
        };

        volumes = [
          "${cfg.impressumFile}:/app/impressum.html:ro"
          "${cfg.privacyFile}:/app/privacy.html:ro"
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
      @api path /api/*
      header @api Cache-Control "no-transform"

      reverse_proxy * 127.0.0.1:2284
    '';
  };
}
