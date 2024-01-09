{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.services.custom.bird2;
  birdConfig = (pkgs.callPackage ../../../pkgs/routing-rocks-policy {
    vars = cfg.configYML;
    as-sets = cfg.asSets; 
  });

in {
  options = {
    services.custom.bird2 = {
      enable = mkEnableOption "Bird Routing Daemon";
      asSets = mkOption {
        type = types.str;
        default = "";
        description = "AS sets in bird config format";
        example = ''
          define AS_FFE = [
            2a0c:efc0::/29
          ];
        '';
      };
      configYML = mkOption {
        type = types.str;
        description = ''
          Configuration for routing-rocks policy
          (see https://github.com/czerwonk/routing-rocks-policy-role)

          This YAML based config is used as datasource to build the bird configuration
        '';
      };
    };
  }; 
  
  config = mkIf cfg.enable {
    services.bird2 = {
      enable = true;
      checkConfig = true;
      config = (builtins.readFile "${birdConfig}/bird.conf");
    };
  };
}
