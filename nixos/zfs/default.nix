{ pkgs, lib, ... }:

{
  imports = [
    ./common.nix
  ];

  boot.kernelPackages = lib.mkForce pkgs.linuxKernel.packages.linux_hardened;
  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_hardened.zfs_2_4
  ];
}
