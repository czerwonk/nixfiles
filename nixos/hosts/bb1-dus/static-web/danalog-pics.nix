{
  services.caddy.virtualHosts."danalog.pics".extraConfig = ''
    import common
    import cloudflare_only

    root * /var/www/danalog-pics/public

    file_server {
      precompressed
    }

    header {
      Content-Security-Policy: "default-src 'self'; script-src 'self'; style-src 'self' 'unsafe-inline'; img-src 'self' data:; font-src 'self'; connect-src 'self'; frame-ancestors 'none'; form-action 'self';"

      Access-Control-Allow-Origin "null"
      Cross-Origin-Embedder-Policy "require-corp"
      Cross-Origin-Opener-Policy "same-origin"
      Cross-Origin-Resource-Policy "same-origin"

      Strict-Transport-Security "max-age=63072000; includeSubDomains; preload"

      X-Frame-Options "DENY"
      X-Content-Type-Options "nosniff"

      Referrer-Policy "no-referrer"

      Permissions-Policy "accelerometer=(), camera=(), geolocation=(), gyroscope=(), magnetometer=(), microphone=(), payment=(), usb=()"
      -Server
    }
  '';

  services.caddy.virtualHosts."private.danalog.pics".extraConfig = ''
    import private

    root * /var/www/danalog-pics/private

    file_server {
      precompressed
    }

    header {
      Content-Security-Policy: "default-src 'self'; script-src 'self'; style-src 'self' 'unsafe-inline'; img-src 'self' data:; font-src 'self'; connect-src 'self'; frame-ancestors 'none'; form-action 'self';"

      Access-Control-Allow-Origin "null"
      Cross-Origin-Embedder-Policy "require-corp"
      Cross-Origin-Opener-Policy "same-origin"
      Cross-Origin-Resource-Policy "same-origin"

      Strict-Transport-Security "max-age=63072000; includeSubDomains; preload"

      X-Frame-Options "DENY"
      X-Content-Type-Options "nosniff"

      Referrer-Policy "no-referrer"

      Permissions-Policy "accelerometer=(), camera=(), geolocation=(), gyroscope=(), magnetometer=(), microphone=(), payment=(), usb=()"
      -Server
    }
  '';
}
