{ pkgs, lib, ... }:

{
  networking.networkmanager.dns = "none";
  networking.nameservers = lib.mkDefault [ "1.1.1.1" "2606:4700:4700::1111" "8.8.8.8" ];

  services.resolved.enable = false;

  services.dnsmasq = {
    enable = lib.mkDefault true;
    settings = {
      listen-address = "127.0.0.1";
      interface = "lo";
      bind-interfaces = true;
      server = [ "127.0.0.53" ];
      strict-order = true;
      domain-needed = true;
      bogus-priv = true;
      no-resolv = true;
      cache-size = 1000;
      no-hosts = true;
      conf-file = "${pkgs.dnsmasq}/share/dnsmasq/trust-anchors.conf";
      dnssec = true;
      dnssec-check-unsigned = true;
    };
  };

  services.stubby = {
    enable = lib.mkDefault true;
    settings = {
      listen_addresses = [ "127.0.0.53" ];
      resolution_type = "GETDNS_RESOLUTION_STUB";
      tls_authentication = "GETDNS_AUTHENTICATION_REQUIRED";
      dnssec_return_status = "GETDNS_EXTENSION_TRUE";
      tls_min_version = "GETDNS_TLS1_3";
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
          address_data = "2606:4700:4700::1111";
          tls_auth_name = "one.one.one.one";
          tls_pubkey_pinset = [{
            digest = "sha256";
            value = "GP8Knf7qBae+aIfythytMbYnL+yowaWVeD6MoLHkVRg=";
          }];
        }
        {
          address_data = "8.8.8.8";
          tls_auth_name = "dns.google";
          tls_pubkey_pinset = [{
            digest = "sha256";
            value = "dt62L3fioBWsybJVDcZTHdpbcYRplCeuhNoUHHW/xVc=";
          }];
        }
      ];
    };
  };
}
