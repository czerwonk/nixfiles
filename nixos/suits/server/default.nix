{ pkgs, ... }:

{
  imports = [
    ./sysctl.nix
    ./hardening.nix
    ./impermanence.nix
  ];

  networking.useNetworkd = true;
  networking.useDHCP = false;
  systemd.network = {
    enable = true;
  };

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
    enable = true;
    openFirewall = true;
  };
}
