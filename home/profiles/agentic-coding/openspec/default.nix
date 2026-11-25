{ pkgs, ... }:

{
  home.packages = [ pkgs.openspec ];

  home.sessionVariables.OPENSPEC_TELEMETRY = "0";

  xdg.configFile."openspec/config.json".text = builtins.toJSON {
    featureFlags = { };
    profile = "core";
    delivery = "commands";
  };
}
