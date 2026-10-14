{ pkgs, ... }:

{
  imports = [
    ./uinput.nix
  ];

  environment.systemPackages = [ pkgs.tuxbox ];
  services.udev.extraRules = ''
    # TourBox NEO
    SUBSYSTEM=="tty", ATTRS{idVendor}=="cafe", ATTRS{idProduct}=="4001", \
      MODE="0660", GROUP="plugdev", ENV{ID_MM_DEVICE_IGNORE}="1", \
      SYMLINK+="tourbox", TAG+="systemd", ENV{SYSTEMD_USER_WANTS}="tuxbox.service"
  '';

  systemd.user.services.tuxbox = {
    description = "TuxBox TourBox driver";
    bindsTo = [ "dev-tourbox.device" ];
    after = [
      "dev-tourbox.device"
      "graphical-session.target"
    ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.tuxbox}/bin/tuxbox";
      Restart = "on-failure";
      RestartSec = "5s";
    };
  };
}
