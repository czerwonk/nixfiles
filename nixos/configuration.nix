{ pkgs, username, hostname, ... }:

{
  imports = [
    ./hardening
    ./impermanence.nix
  ];

  boot.supportedFilesystems = [ "btrfs" ];
  boot.kernelModules = [
    "xt_nat"
    "xt_connmark"
    "xt_mark"
    "xt_comment"
    "xt_limit"
    "xt_addrtype"
    "xt_multiport"
    "wireguard"
    "btrfs"
    "xfs"
    "ext4"
  ];
  boot.swraid.enable = true;

  environment.defaultPackages = with pkgs; [
    file
    rsync
    strace
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
    ntp
    gnupg
    gitFull
    vim 
    wget
    unzip
    wireguard-tools
    lsof
    mdadm
  ];
  environment.shells = [ pkgs.zsh ];

  system.stateVersion = "23.11";
}
