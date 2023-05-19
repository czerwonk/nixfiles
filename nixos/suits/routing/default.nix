{ pkgs, ... }:

{
  imports = [
    ./sysctl.nix
  ];

  services.bird2 = {
    enable = true;
    config = [
      "include /etc/bird.conf"
    ];
    checkConfig = false;
  };
}
