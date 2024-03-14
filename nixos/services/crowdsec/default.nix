{ inputs, ... }:

{
  nixpkgs.overlays = [inputs.crowdsec.overlays.default];

  imports = [
    inputs.crowdsec.nixosModules.crowdsec
    inputs.crowdsec.nixosModules.crowdsec-firewall-bouncer
    ./crowdsec.nix
    ./caddy.nix
  ];

  my.services.crowdsec.collections = [
    "crowdsecurity/linux"
    "crowdsecurity/iptables"
  ];
}
