{ pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ../../configuration.nix
  ];

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    useOSProber = true;
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
    };
  };
}
