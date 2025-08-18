{ lib, config, ... }:

with lib;

let
  cfg = config.my.services.monitoring;

in
{
  config = mkIf cfg.enable {
    services.alloy.enable = true;

    environment.etc."alloy/config.alloy".text = builtins.readFile ./config.alloy;
  };
}
