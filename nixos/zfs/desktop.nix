{ pkgs, lib, ... }:

{
  imports = [
    ./common.nix
  ];

  boot.kernelPackages = lib.mkForce pkgs.linuxKernel.packages.linux_7_0;

  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_7_0.zfs_2_4
  ];
}
