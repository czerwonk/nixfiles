{ pkgs,  ... }:

{
  boot.supportedFilesystems = [ "zfs" ];
  boot.initrd.kernelModules = [ "zfs" ];
  boot.zfs.package = pkgs.unstable.zfs_unstable;

  boot.kernelPackages = pkgs.unstable.linuxKernel.packages.linux_6_10;
  environment.systemPackages = with pkgs; [
    unstable.linuxKernel.packages.linux_6_10.zfs_unstable
    sanoid
    lzop
    mbuffer
  ];

  services.zfs.trim.enable = true;
}
