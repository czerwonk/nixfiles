{ lib, config, ... }:

with lib;

let
  cfg = config.my.services.netdata;

in {
  options = {
    my.services.netdata.enable = mkEnableOption "Netdata Monitoring";

    my.services.netdata.receiver = mkOption {
      type = types.bool;
      default = false;
      description = "Wether the node should receive metrics from other nodes";
    };
  };

  config = mkIf cfg.enable {
    services.netdata = {
      enable = true;
      config = mkIf (!cfg.receiver) {
        global = {
          "memory mode" = "none";
        };
        web = {
          mode = "none";
          "accept a streaming request every seconds" = 0;
        };
      };
      configDir."stream.conf" = pkgs.writeText "stream.conf" ''
        enabled = yes
        enable compression = yes
        destination = netdata.routing.rocks:19999
        api key = b0c88ae5-53e1-4ef7-9083-42ec8ef77a18
        ${optionalString (cfg.receiver) ''

          [b0c88ae5-53e1-4ef7-9083-42ec8ef77a18]
          enabled = yes
          default history = 3600
          default memory mode = dbengine
          health enabled by default = auto
          allow from = 2001:678:1e0::/48
        ''}
      '';
    };
  };
}
