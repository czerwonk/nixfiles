{ pkgs, lib, ... }:

{
  boot.supportedFilesystems = [ "zfs" ];

  boot.zfs.forceImportRoot = lib.mkDefault false;

  boot.kernelPackages = lib.mkForce pkgs.linuxKernel.packages.linux_6_7_hardened;
  environment.systemPackages = [
    pkgs.linuxKernel.packages.linux_6_7_hardened.zfs
  ];

  services.zfs.trim.enable = true;
}
