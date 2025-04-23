{ lib, config, ... }:

let
  nat = config.networking.nat;

in
{
  networking.nftables.tables."nixos-nat".family = "ip";
  networking.nftables.tables."nixos-nat".content = lib.mkAfter ''
    chain post {
      type nat hook postrouting priority srcnat - 1; policy accept;
      ${lib.flip lib.concatMapStrings config.networking.nat.internalInterfaces (iface: ''
        iifname "${iface}" oifname "${nat.externalInterface}" snat ip to ${nat.externalIP}
      '')}
    }
  '';
}
