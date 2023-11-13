{ lib, config, username, ... }:

{
  services.openssh = {
    enable = true;
    ports = [ 2222 ];
    openFirewall = true;
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
      ChrootDirectory = "%h";

      AllowAgentForwarding = false;
      AllowTcpForwarding = false;
      PrintMotd = false;
      UseDns = false;
    };
    extraConfig = lib.mkForce ''
      AuthorizedKeysFile ${toString config.services.openssh.authorizedKeysFiles}
      Subsystem sftp internal-sftp

      Match User ${username}
        AllowAgentForwarding yes
        AllowTcpForwarding yes
        ChrootDirectory none
    '';
  };
}
