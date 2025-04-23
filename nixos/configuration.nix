{ pkgs, username, ... }:

{
  imports = [
    ./common.nix
    ./dns.nix
    ./hardening
    ./impermanence.nix
    ./wrappers.nix
  ];

  boot.supportedFilesystems = [ "btrfs" ];
  boot.kernelModules = [
    "8021q"
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
  boot.kernel.sysctl = {
    "vm.max_map_count" = 1048576;
  };

  services.journald.extraConfig = ''
    SystemMaxUse=10000M
    MaxFileSec=30day
  '';

  users.users.${username} = {
    uid = 1000;
    isNormalUser = true;
    description = "Daniel Brendgen-Czerwonk";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  system.stateVersion = "23.11";
}
