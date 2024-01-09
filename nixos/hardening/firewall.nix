{ lib, ... }:

{
  networking.firewall.enable = true;
  networking.firewall.checkReversePath = "loose";
  networking.firewall.filterForward = lib.mkDefault true;

  networking.nftables.enable = lib.mkDefault true;
  networking.nftables.tables."nixos-fw".content = lib.mkAfter ''
        chain log-and-drop {
          tcp flags syn / fin,syn,rst,ack log prefix "refused connection: " level info
          drop
        }
  '';
}
