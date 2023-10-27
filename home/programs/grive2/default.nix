{ pkgs, config, ... }:

{
  home = {
    packages = with pkgs; [
      grive2
    ];
    file.".scripts/grive2/grive-sync.sh".source = ./grive-sync.sh;
    file.".config/systemd/user/grive@.service".text = ''
      [Unit]
      Description=Google drive sync (main)
      Requires=grive-timer@%i.timer grive-changes@%i.service

      # dummy service
      [Service]
      Type=oneshot
      ExecStart=${pkgs.coreutils}/bin/true
      # This service shall be considered active after start
      RemainAfterExit=yes

      [Install]
      WantedBy=default.target
    '';
    file.".config/systemd/user/grive-timer@.timer".text = ''
      [Unit]
      Description=Google drive sync (fixed intervals)

      [Timer]
      OnCalendar=*:0/5
      OnBootSec=3min
      OnUnitActiveSec=5min
      Unit=grive-timer@%i.service

      [Install]
      WantedBy=timers.target
    '';
    file.".config/systemd/user/grive-changes@.service".text = ''
      [Unit]
      Description=Google drive sync (changed files)

      [Service]
      ExecStart=/run/current-system/sw/bin/bash ${config.home.homeDirectory}/.scripts/grive2/grive-sync.sh listen "%i"
      Type=simple
      Restart=always
      RestartSec=30

      [Install]
      WantedBy=default.target
    '';
    file.".config/systemd/user/grive-timer@.service".text = ''
      [Unit]
      Description=Google drive sync (executed by timer unit)
      After=network-online.target

      [Service]
      ExecStart=/run/current-system/sw/bin/bash ${config.home.homeDirectory}/.scripts/grive2/grive-sync.sh sync "%i"
    '';
  };
}
