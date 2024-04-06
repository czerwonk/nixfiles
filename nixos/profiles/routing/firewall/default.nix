{ lib, config, ... }:

{
  imports = [
    ./forward.nix
    ./input.nix
    ./nat.nix
    ./options.nix
  ];

  networking.nftables.tables."nixos-fw".content = lib.mkOrder 5 ''
    set outside-interfaces {
      type ifname
      elements = { ${lib.concatMapStringsSep "," (s: ''"${s}"'') config.networking.firewall.outsideInterfaces} }
    }

    set bogon-v4 {
      typeof ip saddr
      flags interval
      elements = {
        10.0.0.0/8,      # RFC 1918
        172.16.0.0/12,   # RFC 1918
        192.168.0.0/16,  # RFC 1918
        198.51.100.0/24, # RFC 5737
        203.0.113.0/24,  # RFC 5737
        192.0.2.0/24,    # RFC 5737
        169.254.0.0/16,  # RFC 3927
        127.0.0.0/8,     # RFC 1122
        100.64.0.0/10    # RFC 6598
      }
    }

    set bogon-v6 {
      typeof ip6 saddr
      flags interval
      elements = {
        ::1/128,
        ff00::/8
      }
    }
  '';
}
