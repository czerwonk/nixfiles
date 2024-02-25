{ pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  nixpkgs.overlays = [(final: super: {
    zfs = super.zfs.overrideAttrs(_: {
      meta.platforms = [];
    });
  })];

  boot.supportedFilesystems = [ "bcachefs" ];

  environment.systemPackages = with pkgs; [
    keyutils
  ];
}
