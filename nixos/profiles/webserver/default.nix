{ lib, ... }:

{
  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  services.caddy = {
    enable = true;
    adapter = "caddyfile";
    extraConfig = lib.mkBefore ''
      (common) {
        header /* {
          -Server
        }

        rate_limit {
          zone ddos_protection {
            key {remote_host}
            events 1000
            window 60s
            burst 100
          }
        }
      }

      (private) {
        import common

        @blocked not remote_ip 2001:678:1e0::/48
        abort @blocked
      }
    '';
  };
}
