# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, modulesPath, ... }:

{
  imports = [ 
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usb_storage" "uas" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  boot.initrd.luks.devices."enc".device = "/dev/disk/by-uuid/94d76b04-4757-4418-b3f7-18274c471435";

  fileSystems."/boot" = { 
    device = "/dev/disk/by-uuid/3278-6A86";
    fsType = "vfat";
  };

  fileSystems."/" = { 
    device = "/dev/disk/by-uuid/33d74fce-569c-4fdb-ae1c-a2933f93ef54";
    fsType = "btrfs";
    options = [ 
      "subvol=root"
      "compress=zstd"
      "noatime" 
      "nosuid"
      "nodev"
    ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/33d74fce-569c-4fdb-ae1c-a2933f93ef54";
    fsType = "btrfs";
    options = [ "subvol=nix" "compress=zstd" "noatime" ];
  };

  fileSystems."/persist" = {
    device = "/dev/disk/by-uuid/33d74fce-569c-4fdb-ae1c-a2933f93ef54";
    fsType = "btrfs";
    options = [ "subvol=persist" "compress=zstd" "noatime" ];
    neededForBoot = true;
  };

  swapDevices = [
    { device = "/var/lib/swapfile"; size = 64*1024; }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}