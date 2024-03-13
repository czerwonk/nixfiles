{ pkgs, ... }:

{
  imports = [
    ./firewall.nix
    ./sysctl.nix
  ];

  routing-rocks.bird2.enable = true;

  systemd.network.wait-online.anyInterface = true;

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
      ];
      ports = [ "127.0.0.1:3323:3323" ];
    };
  };
}
