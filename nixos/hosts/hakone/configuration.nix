{
  imports = [
    ./hardware-configuration.nix
    ../../configuration.nix
    ../../profiles/amd-rocm
    ../../profiles/container
    ../../profiles/server
    ../../profiles/virtualisation
    ../../tpm.nix
    ../../zfs/desktop.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelParams = [
    "pcie_port_pm=off"
    "pci=realloc,hpiosize=0,hpmemsize=128M"
  ];
  services.udev.extraRules = ''
    # Authorize all Thunderbolt devices
    ACTION=="add", SUBSYSTEM=="thunderbolt", ATTR{authorized}=="0", ATTR{authorized}="1"

    # Also try to authorize at the domain level
    ACTION=="add", SUBSYSTEM=="thunderbolt", TEST=="authorized", ATTR{authorized}="2"

    # Keep PCIe bridges active
    ACTION=="add", SUBSYSTEM=="pci", ATTR{class}=="0x060400", ATTR{power/control}="on"
  '';

  boot.zfs.requestEncryptionCredentials = [ "zroot" ];

  boot.extraModprobeConfig = ''
    options usbserial vendor=0403 product=6001
  '';

  boot.tmp = {
    useTmpfs = true;
    tmpfsSize = "24G";
    cleanOnBoot = false;
  };

  networking = {
    hostName = "hakone";
    hostId = "a7f2e1c4";
    useNetworkd = false;
    useDHCP = false;
  };
  systemd.network.enable = false;

  security.lockKernelModules = false;
  security.pam.u2f.enable = false;

  services.fwupd.enable = true;

  services.printing.enable = true;

  services.fprintd.enable = true;

  services.dnsmasq.settings.no-hosts = false;

  powerManagement.cpuFreqGovernor = "ondemand";
  services.power-profiles-daemon.enable = true;
}
