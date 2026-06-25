{
  services.unifi.enable = true;

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
