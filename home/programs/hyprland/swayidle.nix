{ pkgs, ... }:

{
  services.swayidle = {
    enable = true;
    events = [
      { event = "before-sleep"; command = "${pkgs.swaylock-effects}/bin/swaylock -fF"; }
      { event = "lock"; command = "lock"; }
    ];
    timeouts = [
      { timeout = 300; command = "${pkgs.swaylock}/bin/swaylock -fF"; }
      { timeout = 900; command = "${pkgs.systemd}/bin/systemctl suspend"; }
    ];
  };
}
