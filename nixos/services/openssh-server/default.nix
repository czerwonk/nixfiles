{ lib, config, username, ... }:

with lib;

let
  cfg = config.services.custom.openssh-server;

in {
  options = {
    services.custom.openssh-server = {
      enable = mkEnableOption "OpenSSH Server";

      openFirewall = mkOption {
        description = "Wether to open firewall ports";
        type = types.bool;
        default = true;
      };
    };
  };

  config = mkIf cfg.enable {
    users.groups.ssh = {};
    users.groups.sftp = {};

    users.users.${username} = {
      extraGroups = [ "ssh" "sftp" ];
    };

    services.openssh = {
      enable = true;
      ports = [ 2222 ];
      openFirewall = cfg.openFirewall;
      settings = {
        Port = 2222;
        TCPKeepAlive = false;
        Compression = false;

        # Logging
        SyslogFacility = "AUTHPRIV";
        LogLevel = "VERBOSE";

        # Authentication
        AllowGroups = [ "ssh" "sftp" ];
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
      extraConfig = lib.mkAfter ''
        AuthorizedKeysFile /etc/ssh/authorized_keys.d/%u
        Subsystem sftp internal-sftp

        Match User ${username}
          AllowAgentForwarding yes
          AllowTcpForwarding yes
          ChrootDirectory none

        Match Group sftp
          ForceCommand internal-sftp -d /%u
      '';
    };
  };
}
