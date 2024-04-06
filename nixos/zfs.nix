{ pkgs, lib, ... }:

{
  boot.supportedFilesystems = [ "zfs" ];

  boot.zfs.forceImportRoot = lib.mkDefault false;

  boot.kernelPackages = lib.mkForce pkgs.linuxKernel.packages.linux_6_6_hardened;
  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_6_6_hardened.zfs
    sanoid
    lzop
    mbuffer
  ];

  services.zfs.trim.enable = true;
}
