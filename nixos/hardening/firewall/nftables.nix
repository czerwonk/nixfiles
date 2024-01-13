{ lib, config, ... }:

{
  config = lib.mkIf config.networking.nftables.enable {
    networking.nftables.tables."nixos-fw".content = lib.mkAfter ''
          chain log-and-drop {
            tcp flags syn / fin,syn,rst,ack log prefix "refused connection: " level info
            drop
          }
    '';
  };
}
