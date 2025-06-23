{ pkgs, lib, ... }:

{
  imports = [
    ./common.nix
  ];

  boot.zfs.package = pkgs.unstable.zfs;
  boot.kernelPackages = lib.mkForce pkgs.unstable.linuxKernel.packages.linux_6_15;

  environment.systemPackages = with pkgs; [
    unstable.linuxKernel.packages.linux_6_15.zfs_2_3
  ];
}
