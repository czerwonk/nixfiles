{ pkgs, lib, ... }:

{
  boot.supportedFilesystems = [ "zfs" ];

  boot.zfs.forceImportRoot = false;

  boot.kernelPackages = lib.mkForce pkgs.linuxKernel.packages.linux_6_6_hardened;
  environment.systemPackages = [
    pkgs.linuxKernel.packages.linux_6_6_hardened.zfs
  ];
}
