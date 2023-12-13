{ pkgs, username, ... }:

{
  imports = [
    ./sysctl.nix
    ./sshd.nix
    ./hardening.nix
    ./impermanence.nix
  ];

  boot.swraid.enable = true;

  users.groups.ssh = {};
  users.users.${username} = {
    extraGroups = [ "ssh" ];
  };

  networking.useNetworkd = true;
  networking.nameservers = [ "1.1.1.1" "2606:4700:4700::1111" "8.8.8.8" ];
  networking.useDHCP = false;
  systemd.network = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    wireguard-tools
  ];

  services.rsyslogd.enable = true;
  services.logrotate.enable = true;
}
