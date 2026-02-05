{
  pkgs,
  lib,
  config,
  ...
}:

{
  config = lib.mkIf config.programs.ghostty.enable {
    programs.ghostty.settings = {
      font-family = "JetBrains Mono";
      font-size = 12;
    };

    home = {
      packages = with pkgs; [
        jetbrains-mono
      ];
    };
  };
}
