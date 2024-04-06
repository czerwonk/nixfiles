{ lib, config, ... }:

{
  imports = [
    ./forward.nix
    ./input.nix
    ./nat.nix
    ./options.nix
  ];

  networking.firewall.extraInputRules = lib.mkOrder 0 ''
    ip6 saddr 2001:678:1e0::/48 iifname @outside-interfaces counter drop comment "spoofed traffic"
  '';

  networking.nftables.tables."nixos-fw".content = lib.mkOrder 20 ''
    set outside-interfaces {
      type ifname
      elements = { ${lib.concatMapStringsSep "," (s: ''"${s}"'') config.networking.firewall.outsideInterfaces} }
    }
  '';
}
