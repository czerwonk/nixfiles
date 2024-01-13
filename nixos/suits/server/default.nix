{ pkgs, lib, ... }:

{
  imports = [
    ./sysctl.nix
    ./hardening.nix
    ./impermanence.nix
  ];

  networking.useNetworkd = lib.mkDefault true;
  networking.useDHCP = lib.mkDefault false;

  systemd.network.enable = lib.mkDefault true;

  environment.systemPackages = with pkgs; [
    wireguard-tools
    borgbackup
  ];

  services.rsyslogd.enable = true;
  services.logrotate.enable = true;

  services.prometheus.exporters.node = {
    enable = true;
    enabledCollectors = [
      "ethtool"
      "systemd"
      "processes"
    ];
  };

  services.custom.openssh-server = {
    enable = lib.mkDefault true;
    openFirewall = lib.mkDefault true;
  };
}
