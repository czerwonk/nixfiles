{ pkgs, lib, username, hostname, ... }:

{
  imports = [
    ./dns.nix
    ./hardening
    ./impermanence.nix
    ./services
    ./wrappers.nix
  ];

  system.activationScripts.diff = ''
    PATH=$PATH:${lib.makeBinPath [ pkgs.nix ]}
    if [[ -e /run/current-system ]]; then
      nix store diff-closures /run/current-system "$systemConfig" || true
    fi
  '';

  boot.supportedFilesystems = [ "btrfs" ];
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

  environment.defaultPackages = with pkgs; [
    file
    rsync
    vim
  ];

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  networking.hostName = hostname;

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  services.journald.extraConfig = ''
    SystemMaxUse=10000M
    MaxFileSec=30day
  '';

  services.xserver = {
    layout = "us";
    xkbVariant = "altgr-intl";
  };
  console.useXkbConfig = true;

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  users.users.${username} = {
    isNormalUser = true;
    description = "Daniel Czerwonk";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    gitFull
    gnupg
    lsof
    mdadm
    neovim
    ntp
    smartmontools
    unzip
    wget
    wireguard-tools
  ];
  environment.shells = [ pkgs.zsh ];

  system.stateVersion = "23.11";
}
