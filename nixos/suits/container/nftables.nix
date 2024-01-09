{ lib, config, ... }:

with lib;

{
  config = mkIf config.networking.nftables.enable {
    networking.firewall.trustedInterfaces = [ "podman*" ];
  };
}
