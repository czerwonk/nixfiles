{ pkgs, lib,  ... }:

{
  imports = [
    ./common.nix
  ];

  boot.zfs.package = pkgs.zfs;

  boot.kernelPackages = lib.mkForce pkgs.linuxKernel.packages.linux_6_10;
  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_6_10.zfs
  ];
}
