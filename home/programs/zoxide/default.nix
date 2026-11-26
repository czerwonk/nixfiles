{ lib, config, ... }:

let
  tv = config.programs.television;
in
{
  programs.zoxide = {
    enable = lib.mkDefault true;
    options = [
      "--cmd cd"
    ];
  };

  xdg.configFile."television/cable/zoxide.toml" = lib.mkIf tv.enable {
    source = "${tv.package}/share/cable/unix/zoxide.toml";
  };
}
