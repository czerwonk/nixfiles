{ pkgs, lib, ... }:

{
  imports = [
    ./common.nix
  ];

  #boot.kernelPackages = lib.mkForce pkgs.linuxKernel.packages.linux_7_0;
  boot.kernelPackages = pkgs.linuxPackagesFor (
    pkgs.linux_7_0.override {
      argsOverride = rec {
        src = pkgs.fetchurl {
          url = "mirror://kernel/linux/kernel/v7.x/linux-${version}.tar.xz";
          sha256 = "sha256:08vm18wx6399phzgr3wz94yga3ab4fyca79445ygvbspm904996b";
        };
        version = "7.0.6";
        modDirVersion = "7.0.6";
      };
    }
  );

  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_7_0.zfs_2_4
  ];
}
