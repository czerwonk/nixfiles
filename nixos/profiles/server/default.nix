{ pkgs, lib, inputs, ... }:

{
  imports = [
    ./hardening.nix
    ./impermanence.nix
    ./sysctl.nix
  ];

  networking.useNetworkd = lib.mkDefault true;
  networking.useDHCP = lib.mkDefault false;

  systemd.network.enable = lib.mkDefault true;

  services.dnsmasq.settings.dnssec = false;

  environment.systemPackages = with pkgs; [
    wireguard-tools
    restic
  ];

  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L"
    ];
    dates = "02:00";
    randomizedDelaySec = "90min";
  };

  services.rsyslogd.enable = true;

  services.logrotate = {
    enable = true;
    settings = {
      header = {
        dateext = true;
        compress = true;
        missingok = true;
        notifempty = true;
      };
      "/var/log/messages" = {
        frequency = "daily";
        rotate = 7;
      };
      "/var/log/warn" = {
        frequency = "daily";
        rotate = 7;
      };
    };
  };

  services.prometheus.exporters.node = {
    enable = true;
    enabledCollectors = [
      "ethtool"
      "systemd"
      "processes"
      "zfs"
    ];
  };
  services.prometheus.exporters.zfs.enable = true;

  my.services.openssh-server = {
    enable = lib.mkDefault true;
    openFirewall = lib.mkDefault true;
  };

  my.services.crowdsec.enable = true;
  my.services.netdata.enable = true;
}
