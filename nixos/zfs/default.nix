{ pkgs, lib, ... }:

{
  imports = [
    ./common.nix
  ];

  boot.kernelPackages = lib.mkForce pkgs.linuxKernel.packages.linux_6_18;

  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_6_18.zfs_2_4
  ];
}
