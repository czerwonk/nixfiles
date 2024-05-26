{ pkgs, lib, ... }:

{
  boot.supportedFilesystems = [ "zfs" ];

  boot.initrd.kernelModules = [ "zfs" ];

  boot.zfs.forceImportRoot = lib.mkDefault false;

  boot.kernelPackages = lib.mkForce pkgs.linuxKernel.packages.linux_6_8_hardened;
  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_6_8_hardened.zfs
    sanoid
    lzop
    mbuffer
  ];

  services.zfs.trim.enable = true;
}
