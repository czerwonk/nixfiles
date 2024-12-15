{ pkgs, lib, ... }:

{
  imports = [
    ./common.nix
  ];

  boot.kernelPackages = lib.mkForce pkgs.linuxKernel.packages.linux_6_6_hardened;
  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_6_6_hardened.zfs
  ];
}
