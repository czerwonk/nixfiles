{ ... }:

{
  imports = [
    ./sysctl.nix
  ];

  services.bird2 = {
    enable = true;
    config = "include /etc/bird/routing-rocks.conf;";
    checkConfig = false;
  };

  virtualisation.oci-containers.backend = "podman";
  virtualisation.oci-containers.containers = {
    routinator = {
      image = "nlnetlabs/routinator";
      autoStart = true;
      ports = [ "127.0.0.1:3323:3323" ];
    };
  };
}
