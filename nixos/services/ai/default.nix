{ lib, config, ... }:

with lib;

let
  cfg = config.my.services.ai;

in {
  options = {
    my.services.ai = {
      enable = mkEnableOption "AI workstation services";
    };
  };

  config = mkIf cfg.enable {
    services.ollama.enable = true;

    virtualisation.oci-containers.containers = {
      open-webui = {
        image = "ghcr.io/open-webui/open-webui:main";

        autoStart = false;
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
