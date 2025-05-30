# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/8F8E-2F3A";
    fsType = "vfat";
  };

  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [
      "size=4G"
      "mode=755"
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
      device = "/dev/disk/by-uuid/4a9998ad-fc9c-45e7-8cba-38dafdb9906b";
    }
    {
      device = "/dev/disk/by-uuid/950be16f-f023-461f-a8c4-d167763d51ce";
    }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
