{
  imports = [
    ./sysctl.nix
  ];

  services.bird2 = {
    enable = true;
    checkConfig = false;
  };

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
