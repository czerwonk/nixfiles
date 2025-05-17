{ pkgs, ... }:

{
  imports = [
    ./firewall
    ./sysctl.nix
  ];

  routing-rocks.bird.enable = true;

  services.prometheus.exporters.bird = {
    enable = true;
    user = "bird2";
  };

  virtualisation.oci-containers.containers = {
    routinator = {
      autoStart = true;
      image = "nlnetlabs/routinator";
      extraOptions = [
        "--runtime=${pkgs.gvisor}/bin/runsc"
        "--ip=10.88.0.2"
      ];
    };
  };
}
