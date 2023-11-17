# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ lib, ... }:

{
  imports = [ ];

  boot.initrd.availableKernelModules = [ "uhci_hcd" "xhci_pci" "ehci_pci" "ata_piix" "ahci" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [ 
      "relatime"
      "size=2G"
      "mode=755"
      "nosuid"
      "nodev"
    ];
  };

  fileSystems."/nix" =
  { 
    device = "/dev/disk/by-uuid/2b34635d-e822-47b9-b038-5e68e0ffd0a8";
    fsType = "ext4";
  };

  fileSystems."/persist" =
  {
    depends = [
      "/nix"
    ];
    device = "/nix/persist";
    fsType = "none";
    options = [ "bind" ];
    neededForBoot = true;
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/49777cfe-5322-4bf3-af0c-6b2e22c2456d";
    fsType = "ext4";
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s5.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.parallels.enable = true;
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "prl-tools" ];
}
