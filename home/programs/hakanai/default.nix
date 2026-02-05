{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.programs.hakanai-cli;

in
{
  options = {
    programs.hakanai-cli.enable = lib.mkEnableOption "hakanai-cli";
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = [
        pkgs.hakanai-cli
      ];
      sessionVariables = {
        HAKANAI_SERVER = "https://hakanai.link";
      };
      shellAliases = {
        hs = "${pkgs.hakanai-cli}/bin/hakanai send";
        hg = "${pkgs.hakanai-cli}/bin/hakanai get";
      };
    };
  };
}
