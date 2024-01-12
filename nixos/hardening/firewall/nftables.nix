{ lib, config, ... }:

{
  config = lib.mkIf config.networking.nftables.enable {
    networking.nftables.tables."nixos-fw".content = lib.mkafter ''
          chain log-and-drop {
            tcp flags syn / fin,syn,rst,ack log prefix "refused connection: " level info
            drop
          }
    '';

    boot.kernelModules = [
      "nft_fib"
      "nft_fib_inet"
      "nft_fib_ipv4"
      "nft_fib_ipv6"
      "nft_log"
      "nft_limit"
      "nft_ct"
      "nft_nat"
    ];
  };
}
