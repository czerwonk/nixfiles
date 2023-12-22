# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, modulesPath, ... }:

{
  imports = [ 
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.resumeDevice = "/dev/disk/by-uuid/e9b4a3f0-5d9e-4e58-bed0-46bb05db181f";
  boot.kernelParams = [ "resume_offset=60264358" ];

  boot.initrd.luks.devices."enc".device = "/dev/disk/by-uuid/69941b1c-f90e-4adb-9391-9ebadffd11fb";

  fileSystems."/boot/efi" = { 
    device = "/dev/disk/by-uuid/0A6C-C29D";
    fsType = "vfat";
  };

  fileSystems."/" = { 
    device = "/dev/disk/by-uuid/e9b4a3f0-5d9e-4e58-bed0-46bb05db181f";
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
    device = "/dev/disk/by-uuid/e9b4a3f0-5d9e-4e58-bed0-46bb05db181f";
    fsType = "btrfs";
    options = [ "subvol=nix" "compress=zstd" "noatime" ];
  };

  fileSystems."/persist" = { 
    device = "/dev/disk/by-uuid/e9b4a3f0-5d9e-4e58-bed0-46bb05db181f";
    fsType = "btrfs";
    options = [ "subvol=persist" "compress=zstd" "noatime" ];
    neededForBoot = true;
  };

  fileSystems."/swap" = {
    device = "/dev/disk/by-uuid/e9b4a3f0-5d9e-4e58-bed0-46bb05db181f";
    fsType = "btrfs";
    options = [ "subvol=swap" "noatime" ];
  };

  swapDevices = [ { device = "/swap/swapfile"; } ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
