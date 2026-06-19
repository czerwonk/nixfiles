{ pkgs, username, ... }:

{
  environment.systemPackages = [ pkgs.tuxbox ];
  services.udev.packages = [ pkgs.tuxbox ];
  users.users.${username}.extraGroups = [ "input" ];

  systemd.user.services.tuxbox = {
    enable = true;
    description = "TuxBox TourBox driver";
    after = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];

    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.tuxbox}/bin/tuxbox";
      Restart = "on-failure";
      RestartSec = "5s";
    };
  };
}
