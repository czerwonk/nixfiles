{
  services.caddy.virtualHosts."danalog.pics".extraConfig = ''
    import common
    import cloudflare_only

    root * /var/www/danalog-pics/public

    file_server {
      precompressed
    }

    # Security: Disable access to the Hugo source files
    header /content/* -1
    header /layouts/* -1

    # Caching: Cache images for 1 year
    handle_path /images/* {
      header Cache-Control "public, max-age=31536000"
    }
  '';
}
