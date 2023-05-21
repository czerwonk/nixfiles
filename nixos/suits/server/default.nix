{ username, ... }:

{
  imports = [
    ./sysctl.nix
    ./sshd.nix
    ./hardening.nix
  ];

  users.groups.ssh = {};
  users.users.${username}.extraGroups = [ "ssh" ];

  services.logrotate.enable = true;
}
