{ pkgs, ... }:

{
  environment.etc."psacct-pre.sh".text = ''
    #!/usr/bin/env bash
    # This script is run before the psacct service is started.
    # It is used to create the /var/log/account directory if it does not exist.
    # This is necessary because the psacct service does not create the directory
    # itself, and will fail to start if the directory does not exist.
    if [ -f /var/log/account/pacct ]; then
      exit 0
    fi

    mkdir -p /var/log/account
    touch /var/log/account/pacct
    chmod 600 /var/log/account/pacct
  '';
  systemd.services.psacct = {
    description = "System accounting daemon";
    wantedBy = [ "multi-user.target" ];
    after = [ "local-fs.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStartPre = "/run/current-system/sw/bin/bash /etc/psacct-pre.sh";
      ExecStart = "${pkgs.acct}/sbin/accton /var/log/account/pacct";
      ExecStop = "${pkgs.acct}/sbin/accton off";
      RemainAfterExit = true;
      Restart = "always";
      RestartSec = 5;
    };
  };
}
