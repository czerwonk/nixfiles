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

    # Hugo fingerprints CSS/JS and gives processed images a _hu_<hash> name: they never change under the same name
    @immutable path_regexp ^/(css/main\..+\.css|js/main\..+\.js)$|_hu_[0-9a-f]+\.(jpe?g|png|webp|gif)$
    header @immutable Cache-Control "public, max-age=31536000, immutable"

    # Fonts keep their name; a replaced font needs a new file name
    @fonts path /fonts/*
    header @fonts Cache-Control "public, max-age=2592000"

    # Pages and feeds are revalidated on every visit (304 if unchanged)
    @pages path / */ *.html *.xml
    header @pages Cache-Control "no-cache"

    # Everything else (original photos, banner, favicon) for a day
    header ?Cache-Control "public, max-age=86400"
  '';
}
