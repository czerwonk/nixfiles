{ pkgs, lib, config, ... }:

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
        [stream]
          enabled = ${if cfg.receiver then "no" else "yes"}
          destination = netdata.routing.rocks
          default port = 19999
          api key = b0c88ae5-53e1-4ef7-9083-42ec8ef77a18
        ${optionalString (cfg.receiver) ''

          [b0c88ae5-53e1-4ef7-9083-42ec8ef77a18]
            enabled = yes
            allow from = 2001:678:1e0:*
            default history = 3600
            default memory mode = dbengine
            health enabled by default = auto
        ''}
      '';
    };

    services.caddy.virtualHosts."netdata.routing.rocks" = mkIf cfg.receiver {
      extraConfig = ''
        @blocked not remote_ip 2001:678:1e0::/48
        abort @blocked

        reverse_proxy * 127.0.0.1:19999
      '';
    };
  };
}
