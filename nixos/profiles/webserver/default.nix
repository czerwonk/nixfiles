{ lib, ... }:

{
  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.caddy = {
    enable = true;
    adapter = "caddyfile";
    globalConfig = lib.mkBefore ''
      (common) {
        header /* {
          -Server
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
