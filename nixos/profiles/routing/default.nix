{
  imports = [
    ./firewall
    ./sysctl.nix
  ];

  routing-rocks.bird.enable = true;

  services.prometheus.exporters.bird = {
    enable = true;
    user = "bird";
  };

  services.routinator = {
    enable = true;
    settings = {
      rtr-listen = [ "127.0.0.1:3323" ];
    };
  };
}
