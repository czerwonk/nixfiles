{
  networking.nameservers = [ "1.1.1.1" "2606:4700:4700::1111" ];

  services.resolved = {
    enable = true;
    dnssec = "true";
    llmnr = "false";
    domains = [ "~." ];
    extraConfig = ''
      DNSOverTLS=yes
      MulticastDNS=no
      ReadEtcHosts=no
      Cache=no-negative
    '';
    fallbackDns = [ "8.8.8.8" "2001:4860:4860::8844" ];
  };
}
