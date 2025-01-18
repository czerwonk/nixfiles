{ pkgs, lib, ... }:

{
  imports = [
    ./common.nix
  ];

  boot.kernelPackages = lib.mkForce pkgs.linuxKernel.packages.linux_6_12_hardened;
  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_6_12_hardened.zfs_2_3
  ];
}
