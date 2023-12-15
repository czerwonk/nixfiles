{
  networking.nameservers = [ "127.0.0.1" ];

  services.resolved.enable = true;

  services.stubby = {
    enable = true;
    settings = {
      listen_addresses = [ "127.0.0.1" "0::1" ];
      resolution_type = "GETDNS_RESOLUTION_STUB";
      upstream_recursive_servers = [{
        address_data = "1.1.1.1";
        tls_auth_name = "cloudflare-dns.com";
        tls_pubkey_pinset = [{
          digest = "sha256";
          value = "GP8Knf7qBae+aIfythytMbYnL+yowaWVeD6MoLHkVRg=";
        }];
      } {
        address_data = "1.0.0.1";
        tls_auth_name = "cloudflare-dns.com";
        tls_pubkey_pinset = [{
          digest = "sha256";
          value = "GP8Knf7qBae+aIfythytMbYnL+yowaWVeD6MoLHkVRg=";
        }];
      }];
    };
  };
}
