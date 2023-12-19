{ pkgs, config, ... }:

{
  services.swayidle = {
    enable = true;
    events = [
      { event = "before-sleep"; command = "${config.programs.swaylock.package}/bin/swaylock -fF"; }
      { event = "lock"; command = "lock"; }
    ];
    timeouts = [
      { timeout = 300; command = "${config.programs.swaylock.package}/bin/swaylock -fF"; }
      { timeout = 900; command = "${pkgs.systemd}/bin/systemctl suspend"; }
    ];
  };
}
