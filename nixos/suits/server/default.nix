{ pkgs, username, ... }:

{
  imports = [
    ./sysctl.nix
    ./sshd.nix
    ./hardening.nix
    ./impermanence.nix
  ];

  users.groups.ssh = {};
  users.users.${username} = {
    extraGroups = [ "ssh" ];
  };

  networking.useNetworkd = true;
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
