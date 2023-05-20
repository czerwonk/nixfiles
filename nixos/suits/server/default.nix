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
      TCPKeepAlive = false;
      Compression = false;

      # Logging
      SyslogFacility = "AUTHPRIV";
      LogLevel = "VERBOSE";

      # Authentication
      AllowUsers = "daniel";
      LoginGraceTime = "1m";
      PermitRootLogin = "no";
      StrictModes = true;
      MaxAuthTries = 3;
      MaxSessions = 2;
      ClientAliveCountMax = 2;
      PubkeyAuthentication = true;
      PasswordAuthentication = false;
      PermitEmptyPasswords = false;
      ChallengeResponseAuthentication = false;
      UsePAM = true;
      GSSAPIAuthentication = false;
      GSSAPICleanupCredentials = false;

      AllowAgentForwarding = true;
      AllowTcpForwarding = true;
      PrintMotd = true;
      UseDNS = false;
    };
  };
}
