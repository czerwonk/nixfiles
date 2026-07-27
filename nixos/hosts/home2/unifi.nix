{ pkgs, ... }:

{
  services.unifi = {
    enable = true;
    unifiPackage = pkgs.unifi;
    mongodbPackage = pkgs.mongodb-7_0;
  };

  services.caddy.virtualHosts."unifi.routing.rocks".extraConfig = ''
    import private

    reverse_proxy 127.0.0.1:8443 {
      header_up Host {host}
      transport http {
        tls_insecure_skip_verify
      }
    }
  '';
}
