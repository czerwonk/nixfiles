{ pkgs, lib, ... }:

{
  imports = [
    ./hardening
    ./services
  ];

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  nixpkgs.config.allowUnfree = true;

  system.activationScripts.diff = ''
    PATH=$PATH:${lib.makeBinPath [ pkgs.nix ]}
    if [[ -e /run/current-system ]]; then
      nix store diff-closures /run/current-system "$systemConfig" || true
    fi
  '';

  environment.defaultPackages = with pkgs; [
    file
    rsync
    neovim
  ];
  environment.systemPackages = with pkgs; [
    btrfs-progs
    ethtool
    git
    gnupg
    htop
    lsof
    mdadm
    ntp
    smartmontools
    tmux
    unzip
    wget
    wireguard-tools
  ];
  environment.shells = [ pkgs.zsh ];

  programs.nano.enable = false;

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

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
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "altgr-intl";
    options = "caps:escape";
  };

  console = {
    earlySetup = true;
    font = "${pkgs.powerline-fonts}/share/consolefonts/ter-powerline-v24n.psf.gz";
    packages = [
      pkgs.powerline-fonts
    ];
    useXkbConfig = true;
  };
}
