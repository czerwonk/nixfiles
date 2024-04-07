{
  imports = [ 
    ./hardware-configuration.nix
    ./persistence.nix
    ../../configuration.nix
    ../../zfs.nix
    ../../profiles/desktop
    ../../profiles/pentest
    ../../profiles/container
    ../../profiles/virtualisation
    ../../profiles/virtualisation/virtualbox.nix
    ../../tpm.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.zfs.forceImportRoot = true;
  boot.zfs.requestEncryptionCredentials = [ "zroot" ];

  boot.extraModprobeConfig = ''
    options usbserial vendor=0403 product=6001
  '';

  boot.tmp.useTmpfs = true;
  boot.tmp.tmpfsSize = "16G";
  boot.tmp.cleanOnBoot = false;

  networking.hostId = "7181c80f";
  networking.firewall.filterForward = false;

  security.lockKernelModules = false;

  services.fwupd.enable = true;

  services.printing.enable = true;

  services.fprintd.enable = true;

  services.dnsmasq.settings.no-hosts = false;

  powerManagement.cpuFreqGovernor = "ondemand";
  services.power-profiles-daemon.enable = true;

  my.services.k3s = {
    enable = true;
    autoStart = false;
  };
}
