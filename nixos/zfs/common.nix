{ pkgs, lib, ... }:

{
  boot.supportedFilesystems = [ "zfs" ];

  boot.initrd.kernelModules = [ "zfs" ];

  boot.zfs.package = pkgs.zfs_2_3;
  boot.zfs.forceImportRoot = lib.mkDefault true;

  environment.systemPackages = with pkgs; [
    sanoid
    lzop
    mbuffer
  ];

  services.zfs.trim.enable = true;
}
