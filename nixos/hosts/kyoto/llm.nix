{ pkgs, ... }:

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
}
