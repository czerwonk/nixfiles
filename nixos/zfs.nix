{ pkgs, lib, ... }:

{
  boot.supportedFilesystems = [ "zfs" ];

  boot.initrd.kernelModules = [ "zfs" ];

  boot.zfs.package = pkgs.unstable.zfs;
  boot.zfs.forceImportRoot = lib.mkDefault false;

  boot.kernelPackages = lib.mkForce pkgs.unstable.linuxKernel.packages.linux_6_9_hardened;
  environment.systemPackages = with pkgs; [
    unstable.linuxKernel.packages.linux_6_9_hardened.zfs
    sanoid
    lzop
    mbuffer
  ];

  services.zfs.trim.enable = true;
}
