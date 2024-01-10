{
  imports = [
    ./sysctl.nix
  ];

  services.custom.bird2.enable = true;

  systemd.network.wait-online.anyInterface = true;

  services.prometheus.exporters.bird = {
    enable = true;
    user = "bird2";
  };

  virtualisation.oci-containers.containers = {
    routinator = {
      image = "nlnetlabs/routinator";
      autoStart = true;
      ports = [ "127.0.0.1:3323:3323" ];
    };
  };
}
