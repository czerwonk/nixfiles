{ pkgs, config, ... }:

{
  services.swayidle = {
    enable = true;
    events = [
      { event = "before-sleep"; command = "${config.programs.swaylock.package}/bin/swaylock -f"; }
      { event = "lock"; command = "${config.programs.swaylock.package}/bin/swaylock -f"; }
    ];
    timeouts = [
      { timeout = 300; command = "${config.programs.swaylock.package}/bin/swaylock -f"; }
      { timeout = 1800; command = "${pkgs.systemd}/bin/systemctl suspend -i"; }
    ];
  };
}
