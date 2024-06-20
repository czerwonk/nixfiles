{ lib, config, ... }:

with lib;

let
  cfg = config.programs.zsh;

in {
  options = {
    programs.zsh.theme.enable = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.theme.enable {
    programs.oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      settings = builtins.fromJSON (builtins.unsafeDiscardStringContext (builtins.readFile ./omp-config.json));
    };
  };
}
