{ pkgs, lib, config, ... }:

{
  services.swayidle = {
    enable = true;
    events = [
      { event = "before-sleep"; command = "${lib.getExe config.programs.swaylock.package} -f"; }
      { event = "lock"; command = "${lib.getExe config.programs.swaylock.package} -f"; }
    ];
    timeouts = [
      { timeout = 300; command = "${lib.getExe config.programs.swaylock.package} -f"; }
      { timeout = 1800; command = "${pkgs.systemd}/bin/systemctl suspend -i"; }
    ];
  };
}
