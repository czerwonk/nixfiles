{ ... }:

{
  imports = [
    ./sysctl.nix
  ];

  services.fail2ban.enable = true;
}
