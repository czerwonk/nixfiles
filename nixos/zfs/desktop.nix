{ pkgs, lib, ... }:

{
  imports = [
    ./common.nix
  ];

  boot.kernelPackages = lib.mkForce pkgs.linuxKernel.packages.linux_7_2;

  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_7_2.zfs_2_4
  ];
}
