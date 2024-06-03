{ pkgs, ... }:

{
  services.unifi = {
    enable = true;
    unifiPackage = pkgs.unifi8;
    mongodbPackage = pkgs.mongodb-6_0;
    openFirewall = false;
  };

  services.caddy.virtualHosts."unifi.routing.rocks".extraConfig = ''
    import private

    reverse_proxy * 127.0.0.1:8443 {
      transport http {
        tls
        tls_insecure_skip_verify
      }
    }
  '';
}
