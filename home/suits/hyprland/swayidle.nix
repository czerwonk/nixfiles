{ pkgs, config, ... }:

{
  services.swayidle = {
    enable = true;
    events = [
      { event = "before-sleep"; command = "${config.programs.swaylock.package}/bin/swaylock -fF"; }
      { event = "lock"; command = "${config.programs.swaylock.package}/bin/swaylock -fF"; }
    ];
    timeouts = [
      { timeout = 900; command = "${config.programs.swaylock.package}/bin/swaylock -fF"; }
      { timeout = 1800; command = "${pkgs.systemd}/bin/systemctl suspend"; }
    ];
  };
}
