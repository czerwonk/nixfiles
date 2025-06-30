{
  pkgs,
  lib,
  config,
  username,
  ...
}:

with lib;

let
  cfg = config.my.services.ollama;
  version = "v0.9.3";

in
{
  options = {
    my.services.ollama = {
      enable = mkEnableOption "Ollama with AMD APU support";

      hsa_override_gfx_version = mkOption {
        type = types.str;
        description = "Override for the GFX version used by HSA (AMD ROCm).";
      };
    };
  };

  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers = {
      ollama = {
        image = "ghcr.io/rjmalagon/ollama-linux-amd-apu:${version}";
        cmd = [ "serve" ];

        autoStart = true;
        pull = "newer";

        extraOptions = [
          "--user=1000"
        ];

        environment = {
          OLLAMA_FLASH_ATTENTION = "true";
          HSA_OVERRIDE_GFX_VERSION = cfg.hsa_override_gfx_version;
          OLLAMA_KV_CACHE_TYPE = "q8_0";
          OLLAMA_DEBUG = "0";
        };

        devices = [
          "/dev/kfd:/dev/kfd"
          "/dev/dri:/dev/dri"
        ];

        ports = [ "127.0.0.1:11434:11434" ];

        volumes = [
          "/home/${username}/.ollama:/home/ubuntu/.ollama"
        ];
      };
    };

    environment.systemPackages = [
      pkgs.ollama-rocm
    ];
  };
}
