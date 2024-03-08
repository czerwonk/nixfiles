{ lib, config, username, ... }:

with lib;

let
  cfg = config.my.services.openssh-server;

in {
  options = {
    my.services.openssh-server = {
      enable = mkEnableOption "OpenSSH Server";

      openFirewall = mkOption {
        description = "Wether to open firewall ports";
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf cfg.enable {
    users.groups.ssh = {};
    users.groups.sftp = {};

    users.users.${username} = {
      extraGroups = [ "ssh" ];
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
        PermitRootLogin = lib.mkForce "no";
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

        Match Group sftp
          ForceCommand internal-sftp -d /%u
          ChrootDirectory %h
      '';
    };
  };
}
