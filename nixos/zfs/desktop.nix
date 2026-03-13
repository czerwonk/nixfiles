{ pkgs, lib, ... }:

{
  imports = [
    ./common.nix
  ];

  boot.kernelPackages = lib.mkForce pkgs.linuxKernel.packages.linux_6_19;

  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_6_19.zfs_2_4
  ];
}
