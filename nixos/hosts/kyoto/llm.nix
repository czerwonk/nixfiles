{ pkgs, lib, ... }:

{
  services.ollama = {
    enable = true;
    package = pkgs.ollama-rocm;
    acceleration = "rocm";
    rocmOverrideGfx = "11.0.1";
    environmentVariables = {
      OLLAMA_FLASH_ATTENTION = "true";
      OLLAMA_KV_CACHE_TYPE = "q8_0";
      OLLAMA_DEBUG = "0";
    };
  };

  services.open-webui = {
    enable = true;
    port = 3000;
    host = "127.0.0.1";
    environment = {
      OLLAMA_API_BASE_URL = "http://127.0.0.1:11434";
      WEBUI_AUTH = "False";
    };
  };
  systemd.services.open-webui.wantedBy = lib.mkForce [ ];
}
