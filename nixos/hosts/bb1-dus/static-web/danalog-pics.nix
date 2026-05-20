{
  services.caddy.virtualHosts."danalog.pics".extraConfig = ''
    import common
    #import cloudflare_only

    root * /var/www/danalog-pics/public

    file_server {
      precompressed
    }
  '';
}
