{
  imports = [ 
    ./hardware-configuration.nix
    ../../configuration.nix
    ../../profiles/desktop
    ../../profiles/pentest
    ../../profiles/container
    ../../profiles/virtualisation
    ../../tpm.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.extraModprobeConfig = ''
    options usbserial vendor=0403 product=6001
  '';

  boot.tmp.useTmpfs = true;
  boot.tmp.tmpfsSize = "16G";
  boot.tmp.cleanOnBoot = false;

  security.lockKernelModules = false;

  services.fwupd.enable = true;

  services.printing.enable = true;

  services.fprintd.enable = true;

  services.dnsmasq.settings.no-hosts = false;

  powerManagement.cpuFreqGovernor = "ondemand";
  services.power-profiles-daemon.enable = true;
}
