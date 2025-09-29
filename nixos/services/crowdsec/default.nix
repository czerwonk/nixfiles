{ inputs, ... }:

{
  imports = [
    "${inputs.nixpkgs-unstable}/nixos/modules/services/security/crowdsec.nix"
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
