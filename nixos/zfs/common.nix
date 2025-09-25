{ pkgs, lib, ... }:

{
  imports = [
    ./sanoid.nix
  ];

  boot.supportedFilesystems = [ "zfs" ];

  boot.initrd.kernelModules = [ "zfs" ];

  boot.zfs.package = lib.mkDefault pkgs.zfs;
  boot.zfs.forceImportRoot = lib.mkDefault true;

  environment.systemPackages = with pkgs; [
    sanoid
    lzop
    mbuffer
  ];

  services.zfs.trim.enable = true;
  services.zfs.autoScrub.enable = true;
}
