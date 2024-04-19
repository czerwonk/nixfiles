# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ lib, ... }:

{
  boot.initrd.availableKernelModules = [ "ata_piix" "ohci_pci" "ehci_pci" "ahci" "sd_mod" "sr_mod" ];

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/BFC5-FFBC";
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
    device = "/dev/disk/by-uuid/a5c1b33b-bf0c-4b5b-a4e7-5ed836ec5153";
    fsType = "ext4";
  };

  fileSystems."/persist" = {
    device = "/dev/disk/by-uuid/014c357b-6e48-48d3-bd55-32f8ff6abe17";
    fsType = "ext4";
    neededForBoot = true;
  };

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
