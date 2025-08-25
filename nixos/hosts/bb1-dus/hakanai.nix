{
  services.caddy.virtualHosts."hakanai.link".extraConfig = ''
    import common
    import cloudflare_only

    reverse_proxy 10.43.48.152:8080 {
      import cloudflare_headers
    }
  '';

  services.caddy.virtualHosts."ntfy.hakanai.link".extraConfig = ''
    import private

    reverse_proxy * 10.43.174.57:8080
  '';
}
