{ pkgs, ... }:

{
  imports = [
    ./sysctl.nix
  ];

  services.bird2 = {
    enable = true;
  };
}
