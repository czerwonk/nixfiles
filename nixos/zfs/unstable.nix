{ pkgs, lib,  ... }:

{
  imports = [
    ./common.nix
  ];

  boot.zfs.package = pkgs.unstable.zfs_unstable;

  boot.kernelPackages = lib.mkForce pkgs.unstable.linuxKernel.packages.linux_6_10;
  environment.systemPackages = with pkgs; [
    unstable.linuxKernel.packages.linux_6_10.zfs_unstable
  ];
}
