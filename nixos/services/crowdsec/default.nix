{
  imports = [
    ./crowdsec.nix
    ./bouncer.nix
    ./caddy.nix
  ];

  services.crowdsec.hub.collections = [
    "crowdsecurity/linux"
    "crowdsecurity/iptables"
    "crowdsecurity/auditd"
  ];
}
