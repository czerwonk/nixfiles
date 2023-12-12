{
  boot.kernelModules = [
    "md"
    "linear"
    "multipath"
    "raid0"
    "raid1"
    "raid5"
    "raid6"
    "raid10"
  ];
  boot.blacklistedKernelModules = [
    "usb-storage"
    "firewire-core"
  ];
}
