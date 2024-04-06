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
      openFirewall = false;
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

    networking.nftables.tables."nixos-fw".content = mkIf cfg.openFirewall (mkOrder 20 ''
      set ssh-ratelimit-v4 {
        type ipv4_addr
        timeout 60s
        flags dynamic
      }

      set ssh-ratelimit-v6 {
        type ipv6_addr
        timeout 60s
        flags dynamic
      }
    '');

    networking.firewall.extraInputRules = mkIf cfg.openFirewall (mkOrder 5 ''
      tcp dport 2222 update @ssh-ratelimit-v4 { ip saddr limit rate 5/minute } accept
      tcp dport 2222 update @ssh-ratelimit-v6 { ip6 saddr limit rate 5/minute } accept
    '');
  };
}
