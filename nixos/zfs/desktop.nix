{ pkgs, lib, ... }:

{
  imports = [
    ./common.nix
  ];

  boot.kernelPackages = lib.mkForce pkgs.linuxKernel.packages.linux_6_12;
  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_6_12.zfs
  ];
}