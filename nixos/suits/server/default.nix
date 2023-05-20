{ ... }:

{
  imports = [
    ./sysctl.nix
		./hardening.nix
  ];

  services.fail2ban.enable = true;
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
    };
  };
}
