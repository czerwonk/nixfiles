{ pkgs, lib, ... }:

{
  imports = [
    ./common.nix
  ];

  boot.kernelPackages = lib.mkForce pkgs.linuxKernel.packages.linux_6_14;
  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_6_14.zfs_2_3
  ];
}
