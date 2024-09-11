{ pkgs, lib, ... }:

{
  boot.supportedFilesystems = [ "zfs" ];

  boot.initrd.kernelModules = [ "zfs" ];

  boot.zfs.forceImportRoot = lib.mkDefault true;

  environment.systemPackages = with pkgs; [
    sanoid
    lzop
    mbuffer
  ];

  services.zfs.trim.enable = true;
}