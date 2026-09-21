{ lib, pkgs, ... }:

{
  xdg.configFile = {
    "cosmic/com.system76.CosmicSettings.Shortcuts/v1/system_actions" = {
      enable = true;
      force = true;
      text = ''
        {
            Terminal: "${lib.getExe pkgs.ghostty} --gtk-single-instance=true",
        }
      '';
    };
    "cosmic/com.system76.CosmicSettings.Shortcuts/v1/custom" = {
      enable = true;
      force = true;
      text = ''
        {
            (modifiers: [Super, Shift], key: "s"): System(Screenshot),
        }
      '';
    };
  };
}
