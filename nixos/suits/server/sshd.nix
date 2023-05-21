{ lib, username, ... }:

{
  services.openssh = {
    enable = true;
    settings = {
      Port = 2222;
      TCPKeepAlive = false;
      Compression = false;

      # Logging
      SyslogFacility = "AUTHPRIV";
      LogLevel = "VERBOSE";

      # Authentication
      AllowGroups = "ssh";
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
    extraConfig = lib.mkForce ''
      Subsystem sftp internal-sftp

      Match User ${username}
        AllowAgentForwarding yes
        AllowTcpForwarding yes
        ChrootDirectory none
    '';
  };
}
