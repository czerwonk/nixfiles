# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
  boot.kernelModules = [ "kvm-intel" ];

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/D441-2C65";
    fsType = "vfat";
  };

  fileSystems."/" = {
    device = "zroot/root";
    fsType = "zfs";
    options = [
      "noatime"
      "nosuid"
      "nodev"
    ];
  };

  fileSystems."/nix" = {
    device = "zroot/nix";
    fsType = "zfs";
  };

  fileSystems."/persist" = {
    device = "zroot/persist";
    fsType = "zfs";
    neededForBoot = true;
  };

  swapDevices = [
    {
      device = "/dev/disk/by-uuid/8129591d-ae96-4803-b6cb-608b68cee75b";
    }
    {
      device = "/dev/disk/by-uuid/f8c001e1-067b-4c8c-8396-acbd8e31f3e1";
    }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
