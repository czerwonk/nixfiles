{
  networking.nameservers = [ "127.0.0.1" ];

  services.resolved = {
    enable = true;
  };

  services.stubby = {
    enable = true;
    settings = {
      listen_addresses = [ "127.0.0.1" "0::1" ];
      dnssec_return_status = "GETDNS_EXTENSION_TRUE";
      resolution_type = "GETDNS_RESOLUTION_STUB";
      upstream_recursive_servers = [
        {
          address_data = "1.1.1.1";
          tls_auth_name = "one.one.one.one";
          tls_pubkey_pinset = [{
            digest = "sha256";
            value = "GP8Knf7qBae+aIfythytMbYnL+yowaWVeD6MoLHkVRg=";
          }];
        } 
        {
          address_data = "1.0.0.1";
          tls_auth_name = "one.one.one.one";
          tls_pubkey_pinset = [{
            digest = "sha256";
            value = "GP8Knf7qBae+aIfythytMbYnL+yowaWVeD6MoLHkVRg=";
          }];
        }
        {
          address_data = "2606:4700:4700::1111";
          tls_auth_name = "one.one.one.one";
          tls_pubkey_pinset = [{
            digest = "sha256";
            value = "GP8Knf7qBae+aIfythytMbYnL+yowaWVeD6MoLHkVRg=";
          }];
        }
        {
          address_data = "2606:4700:4700::1001";
          tls_auth_name = "one.one.one.one";
          tls_pubkey_pinset = [{
            digest = "sha256";
            value = "GP8Knf7qBae+aIfythytMbYnL+yowaWVeD6MoLHkVRg=";
          }];
        }
      ];
    };
  };
}
