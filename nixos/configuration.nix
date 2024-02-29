{ pkgs, username, hostname, ... }:

{
  imports = [
    ./common.nix
    ./dns.nix
    ./hardening
    ./impermanence.nix
    ./wrappers.nix
  ];

  boot.supportedFilesystems = [
    "bcachefs"
    "btrfs"
  ];
  boot.kernelModules = [
    "af_packet"
    "btrfs"
    "ext4"
    "linear"
    "md"
    "multipath"
    "raid0"
    "raid1"
    "raid10"
    "raid5"
    "raid6"
    "wireguard"
    "xfs"
  ];
  boot.swraid = {
    enable = true;
    mdadmConf = "PROGRAM ${pkgs.coreutils}/bin/true";
  };

  networking.hostName = hostname;

  services.journald.extraConfig = ''
    SystemMaxUse=10000M
    MaxFileSec=30day
  '';

  users.users.${username} = {
    isNormalUser = true;
    description = "Daniel Czerwonk";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  system.stateVersion = "23.11";
}
