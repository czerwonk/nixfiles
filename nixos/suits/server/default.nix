{ username, ... }:

{
  imports = [
    ./sysctl.nix
    ./sshd.nix
    ./hardening.nix
  ];

  users.groups.ssh = {};
  users.users.${username}.extraGroups = [ "ssh" ];

  services.rsyslogd.enable = true;
  services.logrotate.enable = true;
}
