{ pkgs, config, lib, ... }:

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
      server = [ "1.1.1.1" "2606:4700:4700::1111" "8.8.8.8" ];
      strict-order = true;
      domain-needed = true;
      bogus-priv = true;
      no-resolv = true;
      cache-size = 1000;
      no-hosts = lib.mkDefault true;
      conf-file = "${pkgs.dnsmasq}/share/dnsmasq/trust-anchors.conf";
      dnssec = true;
      dnssec-check-unsigned = true;
    };
  };
}
