{ lib, config, ... }:

with lib;

let
  cfg = config.my.services.ai;

in {
  options = {
    my.services.ai = {
      enable = mkEnableOption "AI workstation services";

      acceleration = lib.mkOption {
        type = types.nullOr (types.enum [ false "rocm" "cuda" ]);
        default = null;
        example = "rocm";
      };

      autoStart = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf cfg.enable {
    services.ollama = {
      enable = true;
      acceleration = cfg.acceleration;
    };

    systemd.services.ollama.wantedBy = mkIf (!cfg.autoStart) (lib.mkForce []);

    virtualisation.oci-containers.containers = {
      open-webui = {
        image = "ghcr.io/open-webui/open-webui:main";

        autoStart = cfg.autoStart;
        extraOptions = [
          "--name=open-webui"
          "--hostname=open-webui"
          "--network=host"
          "--add-host=host.containers.internal:host-gateway"
        ];

        environment = {
          "TZ" = "Europe/Berlin";
          "OLLAMA_API_BASE_URL" = "http://127.0.0.1:11434/api";
          "OLLAMA_BASE_URL" = "http://127.0.0.1:11434";
        };

        ports = [
          "127.0.0.1:3000:8080"
        ];

        volumes = [
          "open_webui_data:/app/backend/data"
        ];
      };
    };
  };
}
