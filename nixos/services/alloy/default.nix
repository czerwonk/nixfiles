{
  lib,
  config,
  ...
}:

with lib;

let
  cfg = config.my.services.alloy;

in
{
  options = {
    my.services.alloy = {
      enable = mkEnableOption "Grafana Alloy, a lightweight and flexible observability platform";
    };
  };

  config = mkIf cfg.enable {
    services.alloy.enable = true;

    environment.etc."alloy/config.alloy".text = builtins.readFile ./config.alloy;
  };
}
