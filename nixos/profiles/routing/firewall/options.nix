{ lib, ... }:

with lib;

{
  options = {
    networking.firewall.outsideInterfaces = mkOption {
      type = types.listOf types.str;
      default = [ ];
      example = [ "enp0s2" ];
      description = lib.mdDoc ''
        Traffic coming in from these interfaces is coming from outside of our AS (untrusted)
      '';
    };
  };
}
