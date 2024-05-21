{ config, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ../../configuration.nix
    ../../profiles/desktop
    ../../profiles/container
    ../../profiles/virtualisation
    ../../zfs.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.zfs.forceImportRoot = true;
  boot.zfs.requestEncryptionCredentials = [ "zroot" ];

  boot.extraModprobeConfig = ''
    options usbserial vendor=0403 product=6001
  '';

  boot.tmp.useTmpfs = true;
  boot.tmp.tmpfsSize = "8G";

  networking = {
    hostId = "0ac77f35";
    hostName = "scrapy";
  };

  security.lockKernelModules = false;

  services.printing.enable = true;

  powerManagement.cpuFreqGovernor = "performance";
  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    settings = {
      CPU_BOOST_ON_BAT = 0;

      RUNTIME_PM_ON_BAT = "auto";

      CPU_SCALING_GOVERNOR_ON_AC = "${config.powerManagement.cpuFreqGovernor}";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    };
  };

  my.services.openssh-server.enable = true;

  services.logrotate.checkConfig = false;
}
