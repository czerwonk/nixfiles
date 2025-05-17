{ pkgs, ... }:

{
  imports = [
    ./firewall
    ./sysctl.nix
  ];

  routing-rocks.bird = {
    enable = true;
    package = pkgs.bird3;
  };

  services.prometheus.exporters.bird = {
    enable = true;
    user = "bird";
  };

  services.routinator.enable = true;
}
