{
  boot.blacklistedKernelModules = [
    "usb-storage"
    "firewire-core"
  ];

  my.services.crowdsec.enable = true;
}
