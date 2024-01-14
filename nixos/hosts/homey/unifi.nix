{ pkgs, ... }:

{
  services.unifi = {
    enable = true;
    unifiPackage = pkgs.unifi;
    openFirewall = false;
  };

  services.caddy.virtualHosts."unifi.routing.rocks".extraConfig = ''
    @blocked not remote_ip 2001:678:1e0::/48
    abort @blocked

    reverse_proxy * 127.0.0.1:8443 {
      transport http {
        tls
        tls_insecure_skip_verify
      }
    }
  '';
}
